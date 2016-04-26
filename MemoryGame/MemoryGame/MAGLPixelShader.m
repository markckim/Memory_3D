//
//  MAGLPixelShader.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLPixelShader.h"

@implementation MAGLPixelShader

- (void)loadWithProgram:(GLuint)program
{
    [super loadWithProgram:program];
    _a_Position = glGetAttribLocation(program, "a_Position");
    _a_TexCoordIn = glGetAttribLocation(program, "a_TexCoordIn");
    _u_Texture0 = glGetUniformLocation(program, "u_Texture0");
    _u_NativeResolution = glGetUniformLocation(program, "u_NativeResolution");
    _u_Resolution = glGetUniformLocation(program, "u_Resolution");
    _u_Alpha = glGetUniformLocation(program, "u_Alpha");
}

@end
