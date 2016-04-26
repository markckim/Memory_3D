//
//  MAAccelerationXRoutine.m
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAccelerationXRoutine.h"
#import "MAGLWorldObject.h"
#import "MASpriteParams.h"

@interface MAAccelerationXRoutine ()

@property (nonatomic, assign) double startingDegreesAccelerationX;
@property (nonatomic, assign) double degreesJerkX;
@property (nonatomic, assign) double maxDegreesVelocityX;

@end

@implementation MAAccelerationXRoutine

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
        if (ABS(worldObject.params.degreesRotationVelocityX) > ABS(_maxDegreesVelocityX)) {
            [self succeedWithObject:object userInfo:userInfo];
        }
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationJerkX = _degreesJerkX;
    worldObject.params.degreesRotationAccelerationX = _startingDegreesAccelerationX;
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super succeedWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationVelocityX = _maxDegreesVelocityX;
    worldObject.params.degreesRotationJerkX = 0.0;
    worldObject.params.degreesRotationAccelerationX = 0.0;
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationVelocityX = 0.0;
    worldObject.params.degreesRotationJerkX = 0.0;
    worldObject.params.degreesRotationAccelerationX = 0.0;
}

- (instancetype)initWithStartingDegreesAccelerationX:(double)startingDegreesAccelerationX degreesJerkX:(double)degreesJerkX maxDegreesVelocityX:(double)maxDegreesVelocityX
{
    if (self = [super init]) {
        _startingDegreesAccelerationX = startingDegreesAccelerationX;
        _degreesJerkX = degreesJerkX;
        _maxDegreesVelocityX = maxDegreesVelocityX;
    }
    return self;
}

@end
