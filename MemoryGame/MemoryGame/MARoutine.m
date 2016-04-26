//
//  MARoutine.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"

@interface MARoutine ()

@end

@implementation MARoutine

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    // over-ride
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // over-ride; call super
    if ([self isRunning]) {
        [self failWithObject:object userInfo:userInfo];
    }
    self.state = MARoutineRunning;
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // over-ride; call super
    self.state = MARoutineSucceeded;
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // over-ride; call super
    self.state = MARoutineFailed;
}

// convenience methods

+ (MARoutine *)routine:(MARoutine *)routine startNewRoutine:(MARoutine *)newRoutine object:(id)object userInfo:(NSDictionary *)userInfo
{
    if ([routine isRunning]) {
        [routine failWithObject:object userInfo:userInfo];
    }
    [newRoutine startWithObject:object userInfo:userInfo];
    return newRoutine;
}

- (void)start
{
    [self startWithObject:nil userInfo:nil];
}

- (void)succeed
{
    [self succeedWithObject:nil userInfo:nil];
}

- (void)fail
{
    [self failWithObject:nil userInfo:nil];
}

- (BOOL)isRunning
{
    return _state == MARoutineRunning;
}

- (BOOL)isSucceeded
{
    return _state == MARoutineSucceeded;
}

- (BOOL)isFailed
{
    return _state == MARoutineFailed;

}

@end
