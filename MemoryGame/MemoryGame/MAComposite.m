//
//  MAComposite.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAComposite.h"

static void * MACompositeContext = &MACompositeContext;

@interface MAComposite ()

@property (nonatomic, assign) NSInteger routineFinishCount;

@end

@implementation MAComposite

- (void)dealloc
{
    for (MARoutine *routine in [self routines]) {
        @try {
            [routine removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
        }
        @catch (NSException *exception) {
            // do nothing
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == MACompositeContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(state))]) {
            if ([object state] == MARoutineSucceeded || [object state] == MARoutineFailed) {
                ++_routineFinishCount;
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
        for (MARoutine *routine in [self routines]) {
            [routine actWithObject:object userInfo:userInfo deltaTime:deltaTime];
        }
        if (_routineFinishCount == [[self routines] count]) {
            [self succeed];
        }
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    _routineFinishCount = 0;
    for (MARoutine *routine in [self routines]) {
        [routine addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:0 context:MACompositeContext];
        [routine startWithObject:object userInfo:userInfo];
    }
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    for (MARoutine *routine in [self routines]) {
        if ([routine isRunning]) {
            [routine failWithObject:object userInfo:userInfo];
        }
        @try {
            [routine removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
        }
        @catch (NSException *exception) {
            // do nothing
        }
    }
}

@end
