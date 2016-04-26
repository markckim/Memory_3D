//
//  MAGLWorldShader.m
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLWorldShader.h"

@implementation MAGLWorldShader

- (void)loadWithProgram:(GLuint)program
{
    [super loadWithProgram:program];
    _a_Position = glGetAttribLocation(program, "a_Position");
    _a_TexCoordIn = glGetAttribLocation(program, "a_TexCoordIn");
    _a_Normal = glGetAttribLocation(program, "a_Normal");
    _u_ViewMatrix = glGetUniformLocation(program, "u_ViewMatrix");
    _u_NormalMatrix = glGetUniformLocation(program, "u_NormalMatrix");
    _u_ViewInverseMatrix = glGetUniformLocation(program, "u_ViewInverseMatrix");
    _u_ProjectionMatrix = glGetUniformLocation(program, "u_ProjectionMatrix");
    _u_ModelMatrix = glGetUniformLocation(program, "u_ModelMatrix");
    _u_shouldToonify = glGetUniformLocation(program, "u_shouldToonify");
    _u_Texture0 = glGetUniformLocation(program, "u_Texture0");
    _u_Alpha = glGetUniformLocation(program, "u_Alpha");
    _u_Color = glGetUniformLocation(program, "u_Color");
    _u_shouldColorAll = glGetUniformLocation(program, "u_shouldColorAll");
    _u_shouldColorShape = glGetUniformLocation(program, "u_shouldColorShape");
}

@end
