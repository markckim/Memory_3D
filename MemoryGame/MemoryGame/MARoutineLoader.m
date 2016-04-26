//
//  MARoutineLoader.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutineLoader.h"
#import "MAGLSprite.h"

static void * MARoutineLoaderContext = &MARoutineLoaderContext;

@interface MARoutineLoader ()

@property (nonatomic, strong) MAGLSprite *object;
@property (nonatomic, strong) MARoutine *action;
@property (nonatomic, assign) NSInteger actionFinishCount;

@end

@implementation MARoutineLoader

- (void)dealloc
{
    @try {
        [_action removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
    }
    @catch (NSException *exception) {
        // do nothing
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == MARoutineLoaderContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(state))]) {
            if ([object state] == MARoutineSucceeded || [object state] == MARoutineFailed) {
                ++_actionFinishCount;
                @try {
                    [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
                }
                @catch (NSException *exception) {
                    // do nothing
                }
            }
        }
    }
}

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        if (_actionFinishCount == 1) {
            [self succeed];
        }
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    _actionFinishCount = 0;
    if (_object && _action) {
        [_action addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:0 context:MARoutineLoaderContext];
        [_object loadAction:_action];
        [_object startActing];
    } else {
        NSLog(@"error: object (%@) and/or action (%@) is nil", _object, _action);
    }
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    @try {
        [_action removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
    }
    @catch (NSException *exception) {
        // do nothing
    }
}

- (instancetype)initWithObject:(MAGLSprite *)object action:(MARoutine *)action
{
    if (self = [super init]) {
        _object = object;
        _action = action;
    }
    return self;
}

@end
