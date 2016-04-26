//
//  MAGLFrame.m
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"
#import "vertex_functions.h"

@interface MAGLFrame ()

@end

@implementation MAGLFrame

- (void)dealloc
{
    free(_vertices);
    _vertices = nil;
}

- (void)setupBuffer
{
    // should be implemented by subclasses
}

- (BOOL)isSetup
{
    return glIsBuffer(self.buffer0);
}

- (GLuint)drawMode
{
    return GL_TRIANGLES;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

@end
