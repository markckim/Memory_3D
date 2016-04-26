//
//  MASpriteParams.h
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface MASpriteParams : NSObject

@property (nonatomic, assign) double scaleX;
@property (nonatomic, assign) double scaleY;
@property (nonatomic, assign) double scaleZ;
@property (nonatomic, assign) double rotationX;
@property (nonatomic, assign) double rotationY;
@property (nonatomic, assign) double rotationZ;
@property (nonatomic, assign) double previousRotationX;
@property (nonatomic, assign) double previousRotationY;
@property (nonatomic, assign) double degreesRotationVelocityX;
@property (nonatomic, assign) double degreesRotationVelocityY;
@property (nonatomic, assign) double degreesRotationAccelerationX;
@property (nonatomic, assign) double degreesRotationAccelerationY;
@property (nonatomic, assign) double degreesRotationJerkX;
@property (nonatomic, assign) double degreesRotationJerkY;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic, assign) GLKVector3 positionOffset;
@property (nonatomic, assign) GLKVector3 rotationOffset;
@property (nonatomic, assign) GLKVector3 velocity;

- (instancetype)initWithPosition:(GLKVector3)position rotationX:(double)rotationX rotationY:(double)rotationY;

@end
