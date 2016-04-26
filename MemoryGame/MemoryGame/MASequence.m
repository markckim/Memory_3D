//
//  MASequence.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MASequence.h"
#import "NSMutableArray+Queue.h"

@interface MASequence ()

@property (nonatomic, strong) NSMutableArray *routineQueue;
@property (nonatomic, weak) MARoutine *currentRoutine;

@end

@implementation MASequence

- (void)_checkPopStartRoutineWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    while (![_currentRoutine isRunning] && [self isRunning]) {
        _currentRoutine = [_routineQueue dequeue];
        if (_currentRoutine) {
            // DDLogDebug(@"sequence: starting %@", NSStringFromClass([_currentRoutine class]));
            [_currentRoutine startWithObject:object userInfo:userInfo];
        } else if ([self routines]) {
            // assume queue had run and finished
            [self succeed];
        } else {
            // assume there was no queue because routines is nil
            [self fail];
        }
    }
}

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        [_currentRoutine actWithObject:object userInfo:userInfo deltaTime:deltaTime];
        [self _checkPopStartRoutineWithObject:object userInfo:userInfo];
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    NSArray *routines = [self routines];
    if (routines) {
        _routineQueue = [[NSMutableArray alloc] initWithArray:routines];
        [self _checkPopStartRoutineWithObject:object userInfo:userInfo];
    } else {
        NSLog(@"error: no routines; unable to create queue");
    }
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super succeedWithObject:object userInfo:userInfo];
    [_currentRoutine succeedWithObject:object userInfo:userInfo];
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    [_currentRoutine failWithObject:object userInfo:userInfo];
}

@end
