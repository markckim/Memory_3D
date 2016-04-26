//
//  MAGLSprite.m
//  a5
//
//  Created by Mark Kim on 1/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLSprite.h"
#import "MAAtlasData.h"
#import "MAGLFrame.h"
#import "MASpriteParams.h"
#import "MAAnimation.h"
#import "MAFrameAnimationRoutine.h"
#import "math_functions.h"
#import "vertex_functions.h"

@interface MAGLSprite ()

@property (nonatomic, strong) MARoutine *animationRoutine;
@property (nonatomic, strong) MARoutine *action;

@end

@implementation MAGLSprite

- (void)render
{
    [super render];
    MAGLWorldShader *shader = (MAGLWorldShader *)self.shader;
    glEnableVertexAttribArray(shader.a_Position);
    glEnableVertexAttribArray(shader.a_TexCoordIn);
    glEnableVertexAttribArray(shader.a_Normal);
    glVertexAttribPointer(shader.a_Position, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Position));
    glVertexAttribPointer(shader.a_TexCoordIn, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Texel));
    glVertexAttribPointer(shader.a_Normal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Normal));
    glDrawArrays([self.frame drawMode], 0, self.frame.numVertices);
    glDisableVertexAttribArray(shader.a_Position);
    glDisableVertexAttribArray(shader.a_TexCoordIn);
    glDisableVertexAttribArray(shader.a_Normal);
}

- (void)updateModelViewMatrix
{
    GLKVector3 currentPosition = GLKVector3Add(self.params.position, self.params.positionOffset);
    GLKMatrix4 referenceModelMatrix = GLKMatrix4Identity;
    referenceModelMatrix = GLKMatrix4TranslateWithVector3(referenceModelMatrix, currentPosition);
    referenceModelMatrix = GLKMatrix4RotateZ(referenceModelMatrix, GLKMathDegreesToRadians(self.params.rotationZ));
    referenceModelMatrix = GLKMatrix4RotateY(referenceModelMatrix, GLKMathDegreesToRadians(self.params.rotationY));
    referenceModelMatrix = GLKMatrix4RotateX(referenceModelMatrix, GLKMathDegreesToRadians(self.params.rotationX));
    referenceModelMatrix = GLKMatrix4TranslateWithVector3(referenceModelMatrix, self.params.rotationOffset);
    referenceModelMatrix = GLKMatrix4Scale(referenceModelMatrix, self.params.scaleX, self.params.scaleY, self.params.scaleZ);
    self.modelMatrix = referenceModelMatrix;
    self.normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(self.modelMatrix), NULL);
}

- (void)updateAxisParamsWithDeltaTime:(NSTimeInterval)deltaTime
{
    self.params.positionOffset = GLKVector3Make(self.params.positionOffset.x + self.params.velocity.x * deltaTime,
                                                self.params.positionOffset.y + self.params.velocity.y * deltaTime,
                                                self.params.positionOffset.z + self.params.velocity.z * deltaTime);
}

- (void)updateRotationParamsWithDeltaTime:(NSTimeInterval)deltaTime
{
    // x
    self.params.degreesRotationAccelerationX += self.params.degreesRotationJerkX * deltaTime;
    self.params.degreesRotationVelocityX += self.params.degreesRotationAccelerationX * deltaTime;
    self.params.previousRotationX = self.params.rotationX;
    self.params.rotationX += self.params.degreesRotationVelocityX * deltaTime;
    self.params.rotationX = modCircularDegrees(self.params.rotationX);
    
    // y
    self.params.degreesRotationAccelerationY += self.params.degreesRotationJerkY * deltaTime;
    self.params.degreesRotationVelocityY += self.params.degreesRotationAccelerationY * deltaTime;
    self.params.previousRotationY = self.params.rotationY;
    self.params.rotationY += self.params.degreesRotationVelocityY * deltaTime;
    self.params.rotationY = modCircularDegrees(self.params.rotationY);
}

- (void)update:(NSTimeInterval)deltaTime
{
    [self.action actWithObject:self userInfo:nil deltaTime:deltaTime];
    [self.animationRoutine actWithObject:self userInfo:nil deltaTime:deltaTime];
    [self updateRotationParamsWithDeltaTime:deltaTime];
    [self updateAxisParamsWithDeltaTime:deltaTime];
    [self updateModelViewMatrix];
}

- (void)loadAnimation:(MAAnimation *)animation
{
    if ([_animationRoutine isRunning]) {
        [self stopAnimating];
    }
    _animationRoutine = [[MAFrameAnimationRoutine alloc] initWithAnimation:animation];
}

- (void)startAnimating
{
    [_animationRoutine startWithObject:self userInfo:nil];
}

- (void)stopAnimating
{
    if ([_animationRoutine isRunning]) {
        [_animationRoutine failWithObject:self userInfo:nil];
    }
}

- (void)loadAction:(MARoutine *)action;
{
    if ([_action isRunning]) {
        [_action failWithObject:self userInfo:nil];
    }
    _action = action;
}

- (void)startActing
{
    [_action startWithObject:self userInfo:nil];
}

- (void)stopActing
{
    if ([_action isRunning]) {
        [_action failWithObject:self userInfo:nil];
    }
}

- (BOOL)isActing
{
    return [_action isRunning];
}

- (void)setupWithProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [super setupWithProgram:program userInfo:userInfo];
    self.viewMatrix = GLKMatrix4Identity;
    self.viewInverseMatrix = GLKMatrix4Identity;
    [self updateModelViewMatrix];
}

- (instancetype)initWithPosition:(GLKVector3)position rotationX:(double)rotationX rotationY:(double)rotationY frame:(MAGLFrame *)frame
{
    if (self = [super init]) {
        self.defaultFrame = frame;
        self.frame = frame;
        self.params = [[MASpriteParams alloc] initWithPosition:position rotationX:rotationX rotationY:rotationY];
    }
    return self;
}

@end
