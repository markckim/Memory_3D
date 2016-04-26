//
//  MAParabolicRoutine.m
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAParabolicRoutine.h"
#import "MAGLSprite.h"

@interface MAParabolicRoutine ()

@property (nonatomic, assign) MAAxisDirection axisDirection;
@property (nonatomic, assign) float velocity;
@property (nonatomic, assign) float gravity;
@property (nonatomic, assign) float initialPositionOffset;
@property (nonatomic, assign) NSTimeInterval timeSinceStart;
@property (nonatomic, assign) NSTimeInterval timeToStop;

@end

@implementation MAParabolicRoutine

/**
 * kinematic equation for distance:
 d = v * t + (0.5) * a * t^2
 set d = 0, solve for t
 t = 0, t = -2 * v / a
 */

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLSprite *sprite = (MAGLSprite *)object;
    if (_axisDirection == MAAxisX) {
        _initialPositionOffset = sprite.params.positionOffset.x;
    } else if (_axisDirection == MAAxisY) {
        _initialPositionOffset = sprite.params.positionOffset.y;
    } else if (_axisDirection == MAAxixZ) {
        _initialPositionOffset = sprite.params.positionOffset.y;
    }
    _timeSinceStart = 0.0;
    _timeToStop = -2.0 * _velocity / _gravity;
    if (_timeToStop <= 0.0) {
        NSLog(@"error: something wrong with timeToStop calculation (%f), with velocity (%f), and gravity (%f)", _timeToStop, _velocity, _gravity);
    }
}

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        MAGLSprite *sprite = (MAGLSprite *)object;
        if (_timeSinceStart > _timeToStop) {
            [self succeedWithObject:object userInfo:userInfo];
        } else {
            float incrementalPositionOffset = _velocity * _timeSinceStart + 0.5 * _gravity * pow(_timeSinceStart, 2.0);
            float positionOffset = _initialPositionOffset + incrementalPositionOffset;
            if (_axisDirection == MAAxisX) {
                sprite.params.positionOffset = GLKVector3Make(positionOffset, sprite.params.positionOffset.y, sprite.params.positionOffset.z);
            } else if (_axisDirection == MAAxisY) {
                sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, positionOffset, sprite.params.positionOffset.z);
            } else if (_axisDirection == MAAxixZ) {
                sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, sprite.params.positionOffset.y, positionOffset);
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
        sprite.params.positionOffset = GLKVector3Make(_initialPositionOffset, sprite.params.positionOffset.y, sprite.params.positionOffset.z);
    } else if (_axisDirection == MAAxisY) {
        sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, _initialPositionOffset, sprite.params.positionOffset.z);
    } else if (_axisDirection == MAAxixZ) {
        sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, sprite.params.positionOffset.y, _initialPositionOffset);
    }
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super failWithObject:object userInfo:userInfo];
    MAGLSprite *sprite = (MAGLSprite *)object;
    if (_axisDirection == MAAxisX) {
        sprite.params.positionOffset = GLKVector3Make(_initialPositionOffset, sprite.params.positionOffset.y, sprite.params.positionOffset.z);
    } else if (_axisDirection == MAAxisY) {
        sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, _initialPositionOffset, sprite.params.positionOffset.z);
    } else if (_axisDirection == MAAxixZ) {
        sprite.params.positionOffset = GLKVector3Make(sprite.params.positionOffset.x, sprite.params.positionOffset.y, _initialPositionOffset);
    }
}

- (instancetype)initWithAxisDirection:(MAAxisDirection)axisDirection velocity:(float)velocity gravity:(float)gravity
{
    if (self = [super init]) {
        _axisDirection = axisDirection;
        if (velocity != 0.0 && gravity != 0.0 && (velocity / gravity) < 0.0) {
            _velocity = velocity;
            _gravity = gravity;
        } else {
            NSLog(@"error: something wrong with velocity (%f) and/or gravity (%f)", velocity, gravity);
        }
    }
    return self;
}

@end
