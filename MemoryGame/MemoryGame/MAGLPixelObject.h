//
//  MAGLPixelObject.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLRenderObject.h"

@interface MAGLPixelObject : MAGLRenderObject

@property (nonatomic, assign) GLuint texture0;
@property (nonatomic, assign) GLfloat alpha;
@property (nonatomic, assign) GLfloat nativeResolutionX;
@property (nonatomic, assign) GLfloat nativeResolutionY;
@property (nonatomic, assign) GLfloat resolutionX;
@property (nonatomic, assign) GLfloat resolutionY;

@end
