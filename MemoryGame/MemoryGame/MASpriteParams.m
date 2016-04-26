//
//  MASpriteParams.m
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MASpriteParams.h"

@implementation MASpriteParams

- (instancetype)initWithPosition:(GLKVector3)position rotationX:(double)rotationX rotationY:(double)rotationY
{
    if (self = [super init]) {
        _scaleX = 1.0;
        _scaleY = 1.0;
        _scaleZ = 1.0;
        _rotationX = rotationX;
        _rotationY = rotationY;
        _rotationZ = 0.0;
        _previousRotationX = 0.0;
        _degreesRotationVelocityX = 0.0;
        _degreesRotationAccelerationX = 0.0;
        _degreesRotationJerkX = 0.0;
        _position = position;
        _positionOffset = GLKVector3Make(0.0, 0.0, 0.0);
        _velocity = GLKVector3Make(0.0, 0.0, 0.0);
    }
    return self;
}

@end
