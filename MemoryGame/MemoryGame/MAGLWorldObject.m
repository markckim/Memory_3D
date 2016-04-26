//
//  MAGLWorldObject.m
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLWorldObject.h"
#import "MAGLFrame.h"

@interface MAGLWorldObject ()

@end

@implementation MAGLWorldObject

- (void)render
{
    glUseProgram(self.shader.program);
    glActiveTexture(GL_TEXTURE0);
    glBindBuffer(GL_ARRAY_BUFFER, self.frame.buffer0);
    MAGLWorldShader *shader = (MAGLWorldShader *)self.shader;
    // adding uniforms and texture
    glUniformMatrix4fv(shader.u_ProjectionMatrix, 1, 0, _projectionMatrix.m);
    glUniformMatrix4fv(shader.u_ViewMatrix, 1, 0, _viewMatrix.m);
    glUniformMatrix4fv(shader.u_ModelMatrix, 1, 0, _modelMatrix.m);
    glUniformMatrix4fv(shader.u_ViewInverseMatrix, 1, 0, _viewInverseMatrix.m);
    glUniformMatrix3fv(shader.u_NormalMatrix, 1, 0, _normalMatrix.m);
    glUniform3f(shader.u_Color, _color.x, _color.y, _color.z);
    glUniform1f(shader.u_shouldColorAll, _shouldColorAll);
    glUniform1f(shader.u_shouldColorShape, _shouldColorShape);
    glUniform1f(shader.u_Alpha, _alpha);
    glUniform1f(shader.u_shouldToonify, 0.0); // toonify hard-coded
    glBindTexture(GL_TEXTURE_2D, _frame.texture);
    glUniform1i(shader.u_Texture0, 0);
    // add attributes in subclass
}

- (instancetype)init
{
    if (self = [super init]) {
        self.shader = [[MAGLWorldShader alloc] init];
        _alpha = 1.0;
        _color = GLKVector3Make(0.0, 0.0, 0.0);
    }
    return self;
}

@end
