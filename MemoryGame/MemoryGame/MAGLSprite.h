//
//  MAGLSprite.h
//  a5
//
//  Created by Mark Kim on 1/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLWorldObject.h"

@class MAAnimation;
@class MARoutine;

@interface MAGLSprite : MAGLWorldObject

- (instancetype)initWithPosition:(GLKVector3)position rotationX:(double)rotationX rotationY:(double)rotationY frame:(MAGLFrame *)frame;
- (void)updateModelViewMatrix;
- (void)updateAxisParamsWithDeltaTime:(NSTimeInterval)deltaTime;
- (void)updateRotationParamsWithDeltaTime:(NSTimeInterval)deltaTime;

// frame animation
- (void)loadAnimation:(MAAnimation *)animation;
- (void)startAnimating;
- (void)stopAnimating;

// action
- (void)loadAction:(MARoutine *)action;
- (void)startActing;
- (void)stopActing;
- (BOOL)isActing;

@end
