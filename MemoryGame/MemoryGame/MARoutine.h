//
//  MARoutine.h
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MARoutineState)
{
    MARoutineStateNone,
    MARoutineRunning,
    MARoutineSucceeded,
    MARoutineFailed,
};

@interface MARoutine : NSObject

@property (nonatomic, assign) MARoutineState state;

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime;
- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo;
- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo;
- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo;

// convenience methods
+ (MARoutine *)routine:(MARoutine *)routine startNewRoutine:(MARoutine *)newRoutine object:(id)object userInfo:(NSDictionary *)userInfo;
- (void)start;
- (void)succeed;
- (void)fail;
- (BOOL)isRunning;
- (BOOL)isSucceeded;
- (BOOL)isFailed;

@end
