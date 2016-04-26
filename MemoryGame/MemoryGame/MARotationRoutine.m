//
//  MARotationRoutine.m
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARotationRoutine.h"
#import "MAGLSprite.h"
#import "math_functions.h"

@interface MARotationRoutine ()

@property (nonatomic, assign) MAAxisDirection axisDirection;
@property (nonatomic, assign) float degreesRotationVelocity;
@property (nonatomic, assign) float degreesRotationAmount;
@property (nonatomic, assign) float degreesOriginalRotation;
@property (nonatomic, assign) float degreesFinalRotation;
@property (nonatomic, assign) NSTimeInterval timeSinceStart;
@property (nonatomic, assign) NSTimeInterval timeToStop;

@end

@implementation MARotationRoutine

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    if (_degreesRotationVelocity == 0.0) {
        NSLog(@"error: something wrong with rotationVelocity: %f", _degreesRotationVelocity);
        return;
    }
    MAGLSprite *sprite = (MAGLSprite *)object;
    if (_axisDirection == MAAxisX) {
        _degreesOriginalRotation = sprite.params.rotationX;
        _degreesFinalRotation = modCircularDegrees(sprite.params.rotationX + _degreesRotationAmount);        
    } else if (_axisDirection == MAAxisY) {
        _degreesOriginalRotation = sprite.params.rotationY;
        _degreesFinalRotation = modCircularDegrees(sprite.params.rotationY + _degreesRotationAmount);
    } else if (_axisDirection == MAAxixZ) {
        _degreesOriginalRotation = sprite.params.rotationZ;
        _degreesFinalRotation = modCircularDegrees(sprite.params.rotationZ + _degreesRotationAmount);
    }
    _timeSinceStart = 0.0;
    _timeToStop = ABS(_degreesRotationAmount / _degreesRotationVelocity);
}

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        MAGLSprite *sprite = (MAGLSprite *)object;
        if (_timeSinceStart > _timeToStop) {
            [self succeedWithObject:object userInfo:userInfo];
        } else {
            float rotationAmount = _degreesRotationVelocity * _timeSinceStart;
            float rotation = modCircularDegrees(_degreesOriginalRotation + rotationAmount);
            if (_axisDirection == MAAxisX) {
                sprite.params.rotationX = rotation;
            } else if (_axisDirection == MAAxisY) {
                sprite.params.rotationY = rotation;
            } else if (_axisDirection == MAAxixZ) {
                sprite.params.rotationZ = rotation;
            }
            _timeSinceStart += deltaTime;
        }
    }
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super succeedWithObject:object userInfo:userInfo];
    MAGLSprite *sprite = (MAGLSprite *)object;
    if (_axisDirection == MAAxisX) {
        sprite.params.rotationX = _degreesFinalRotation;
    } else if (_axisDirection == MAAxisY) {
        sprite.params.rotationY = _degreesFinalRotation;
    } else if (_axisDirection == MAAxixZ) {
        sprite.params.rotationZ = _degreesFinalRotation;
    }
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    MAGLSprite *sprite = (MAGLSprite *)object;
    if (_axisDirection == MAAxisX) {
        sprite.params.rotationX = _degreesFinalRotation;
    } else if (_axisDirection == MAAxisY) {
        sprite.params.rotationY = _degreesFinalRotation;
    } else if (_axisDirection == MAAxixZ) {
        sprite.params.rotationZ = _degreesFinalRotation;
    }
}

- (instancetype)initWithAxisDirection:(MAAxisDirection)axisDirection degreesRotationVelocity:(float)degreesRotationVelocity degreesRotationAmount:(float)degreesRotationAmount
{
    if (self = [super init]) {
        _axisDirection = axisDirection;
        _degreesRotationVelocity = degreesRotationVelocity;
        _degreesRotationAmount = degreesRotationAmount;
    }
    return self;
}

@end
