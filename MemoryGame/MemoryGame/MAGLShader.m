//
//  MAGLShader.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLShader.h"

@interface MAGLShader ()

@property (nonatomic, assign) GLuint program;

@end

@implementation MAGLShader

- (void)loadWithProgram:(GLuint)program
{
    _program = program;
}

@end
