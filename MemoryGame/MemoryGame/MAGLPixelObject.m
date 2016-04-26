//
//  MAGLPixelObject.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLPixelObject.h"
#import "MAGLPixelShader.h"
#import "pixel_constants.h"
#import "UIScreen+ScreenSize.h"

@implementation MAGLPixelObject

- (void)render
{
    //GLenum error = glGetError();
    glUseProgram(self.shader.program);
    glActiveTexture(GL_TEXTURE0);
    glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
    
    MAGLPixelShader *shader = (MAGLPixelShader *)self.shader;
    glUniform2f(shader.u_NativeResolution, _nativeResolutionX, _nativeResolutionY);
    glUniform2f(shader.u_Resolution, _resolutionX, _resolutionY);
    glUniform1f(shader.u_Alpha, _alpha);
    glBindTexture(GL_TEXTURE_2D, self.texture0);
    glUniform1i(shader.u_Texture0, 0);
    
    // add attributes
    glEnableVertexAttribArray(shader.a_Position);
    glEnableVertexAttribArray(shader.a_TexCoordIn);
    glVertexAttribPointer(shader.a_Position, 2, GL_FLOAT, GL_FALSE, sizeof(MAPixelVertex), (const GLvoid *)offsetof(MAPixelVertex, Position));
    glVertexAttribPointer(shader.a_TexCoordIn, 2, GL_FLOAT, GL_FALSE, sizeof(MAPixelVertex), (const GLvoid *)offsetof(MAPixelVertex, Texel));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(shader.a_Position);
    glDisableVertexAttribArray(shader.a_TexCoordIn);
}

- (void)setupWithProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [super setupWithProgram:program userInfo:userInfo];
    if (!glIsBuffer(self.buffer0)) {
        glGenBuffers(1, [self bufferRef0]);
        glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
        glBufferData(GL_ARRAY_BUFFER, sizeof(PixelVertices), PixelVertices, GL_STATIC_DRAW);
    }
}

- (void)setProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [super setProgram:program userInfo:userInfo];
    _resolutionX = (GLfloat)[[userInfo objectForKey:@"resolutionX"] floatValue];
    _resolutionY = (GLfloat)[[userInfo objectForKey:@"resolutionY"] floatValue];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.shader = [[MAGLPixelShader alloc] init];
        CGSize nativeSize = [UIScreen nativePixelSize];
        _nativeResolutionX = nativeSize.width;
        _nativeResolutionY = nativeSize.height;
        _alpha = 1.0;
    }
    return self;
}

@end
