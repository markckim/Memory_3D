//
//  MAGLPixelShader.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLShader.h"

@interface MAGLPixelShader : MAGLShader

@property (nonatomic, assign) GLuint a_Position;
@property (nonatomic, assign) GLuint a_TexCoordIn;
@property (nonatomic, assign) GLuint u_Texture0;
@property (nonatomic, assign) GLuint u_NativeResolution;
@property (nonatomic, assign) GLuint u_Resolution;
@property (nonatomic, assign) GLuint u_Alpha;

@end
