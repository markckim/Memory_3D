//
//  MAGLFrame.h
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLObject.h"
#import "vertex_constants.h"

@class MAAtlasData;
@class MAAtlasSpriteData;

@interface MAGLFrame : MAGLObject

@property (nonatomic, assign) Vertex *vertices;
@property (nonatomic, strong) MAAtlasData *atlasData;
@property (nonatomic, strong) MAAtlasSpriteData *spriteData;
@property (nonatomic, assign) GLsizei numVertices;
@property (nonatomic, assign) GLuint texture;

- (void)setupBuffer;
- (BOOL)isSetup;
- (GLuint)drawMode;

@end
