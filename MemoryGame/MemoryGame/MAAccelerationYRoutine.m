//
//  MAAccelerationYRoutine.m
//  a5
//
//  Created by Mark Kim on 3/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAccelerationYRoutine.h"
#import "MAGLWorldObject.h"
#import "MASpriteParams.h"

@interface MAAccelerationYRoutine ()

@property (nonatomic, assign) double startingDegreesAccelerationY;
@property (nonatomic, assign) double degreesJerkY;
@property (nonatomic, assign) double maxDegreesVelocityY;

@end

@implementation MAAccelerationYRoutine

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
        if (ABS(worldObject.params.degreesRotationVelocityY) > ABS(_maxDegreesVelocityY)) {
            [self succeedWithObject:object userInfo:userInfo];
        }
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationJerkY = _degreesJerkY;
    worldObject.params.degreesRotationAccelerationY = _startingDegreesAccelerationY;
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super succeedWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationVelocityY = _maxDegreesVelocityY;
    worldObject.params.degreesRotationJerkY = 0.0;
    worldObject.params.degreesRotationAccelerationY = 0.0;
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationVelocityY = 0.0;
    worldObject.params.degreesRotationJerkY = 0.0;
    worldObject.params.degreesRotationAccelerationY = 0.0;
}

- (instancetype)initWithStartingDegreesAccelerationY:(double)startingDegreesAccelerationY degreesJerkY:(double)degreesJerkY maxDegreesVelocityY:(double)maxDegreesVelocityY
{
    if (self = [super init]) {
        _startingDegreesAccelerationY = startingDegreesAccelerationY;
        _degreesJerkY = degreesJerkY;
        _maxDegreesVelocityY = maxDegreesVelocityY;
    }
    return self;
}

@end
