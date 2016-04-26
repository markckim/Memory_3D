//
//  MAAxisDampingRoutine.m
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAxisDampingRoutine.h"
#import "MAGLWorldObject.h"
#import "math_functions.h"

@interface MAAxisDampingRoutine ()

@property (nonatomic, assign) NSTimeInterval timeSinceDamping;
@property (nonatomic, assign) NSTimeInterval maxDampingTime;
@property (nonatomic, assign) double initialPositionOffset;
@property (nonatomic, assign) double velocity;
@property (nonatomic, assign) double dampingRatio;
@property (nonatomic, assign) double naturalFrequency;
@property (nonatomic, assign) double dampedFrequency;
@property (nonatomic, assign) MAAxisType axis;

@end

@implementation MAAxisDampingRoutine

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        // NSLog(@"timeSinceDamping: %f, maxDampingTime: %f", _timeSinceDamping, _maxDampingTime);
        MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
        if (_timeSinceDamping > _maxDampingTime) {
            [self succeedWithObject:object userInfo:nil];
            return;
        }
        
        double displacement = dampedDisplacement(_initialPositionOffset, _velocity, _dampingRatio, _naturalFrequency, _dampedFrequency, _timeSinceDamping);
        if (_axis == kAxisX) {
            NSLog(@"error: kAxisX is currently not supported");
        } else if (_axis == kAxisY) {
            worldObject.params.positionOffset = GLKVector3Make(worldObject.params.positionOffset.x, displacement, worldObject.params.positionOffset.z);
        } else if (_axis == kAxisZ) {
            worldObject.params.positionOffset = GLKVector3Make(worldObject.params.positionOffset.x, worldObject.params.positionOffset.y, displacement);
        }
        _timeSinceDamping += deltaTime;
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    _timeSinceDamping = 0.0;
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super succeedWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.positionOffset = GLKVector3Make(worldObject.params.positionOffset.x, 0.0, worldObject.params.positionOffset.z);
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.positionOffset = GLKVector3Make(worldObject.params.positionOffset.x, 0.0, worldObject.params.positionOffset.z);
}

- (instancetype)initWithInitialPosOffset:(double)initialPosOffset initialVelocity:(double)initialVelocity maxDampingTime:(NSTimeInterval)maxDampingTime dampingRatio:(double)dampingRatio naturalFrequency:(double)naturalFrequency dampedFrequency:(double)dampedFrequency axis:(MAAxisType)axis
{
    if (self = [super init]) {
        _initialPositionOffset = initialPosOffset;
        _velocity = initialVelocity;
        _maxDampingTime = maxDampingTime;
        _dampingRatio = dampingRatio;
        _naturalFrequency = naturalFrequency;
        _dampedFrequency = dampedFrequency;
        _axis = axis;
    }
    return self;
}

@end
