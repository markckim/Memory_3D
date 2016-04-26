//
//  MAGLWorldShader.h
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLShader.h"

@interface MAGLWorldShader : MAGLShader

@property (nonatomic, assign) GLuint a_Position;
@property (nonatomic, assign) GLuint a_TexCoordIn;
@property (nonatomic, assign) GLuint a_Normal;
@property (nonatomic, assign) GLuint u_ViewMatrix;
@property (nonatomic, assign) GLuint u_NormalMatrix;
@property (nonatomic, assign) GLuint u_ViewInverseMatrix;
@property (nonatomic, assign) GLuint u_ProjectionMatrix;
@property (nonatomic, assign) GLuint u_ModelMatrix;
@property (nonatomic, assign) GLuint u_shouldToonify;
@property (nonatomic, assign) GLuint u_Texture0;
@property (nonatomic, assign) GLuint u_Alpha;
@property (nonatomic, assign) GLuint u_Color;
@property (nonatomic, assign) GLuint u_shouldColorAll;
@property (nonatomic, assign) GLuint u_shouldColorShape;

@end
