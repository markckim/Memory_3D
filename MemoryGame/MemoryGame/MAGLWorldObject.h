//
//  MAGLWorldObject.h
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLRenderObject.h"
#import "MASpriteParams.h"
#import "MAGLWorldShader.h"
#import "vertex_constants.h"

@class MAGLFrame;

@interface MAGLWorldObject : MAGLRenderObject

@property (nonatomic, strong) MASpriteParams *params;
@property (nonatomic, strong) MAGLFrame *defaultFrame;
@property (nonatomic, strong) MAGLFrame *frame;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, assign) GLKMatrix4 viewMatrix;
@property (nonatomic, assign) GLKMatrix4 modelMatrix;
@property (nonatomic, assign) GLKMatrix4 viewInverseMatrix;
@property (nonatomic, assign) GLKMatrix3 normalMatrix;
@property (nonatomic, assign) GLfloat shouldToonify;
@property (nonatomic, assign) GLKVector3 color;
@property (nonatomic, assign) GLfloat alpha;
@property (nonatomic, assign) bool shouldColorAll;
@property (nonatomic, assign) bool shouldColorShape;

@end
