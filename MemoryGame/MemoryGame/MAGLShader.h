//
//  MAGLShader.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"
#import <GLKit/GLKit.h>

@interface MAGLShader : MAObject

@property (nonatomic, readonly) GLuint program;

- (void)loadWithProgram:(GLuint)program;

@end
