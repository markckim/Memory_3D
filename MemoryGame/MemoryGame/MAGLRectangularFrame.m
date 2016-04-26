//
//  MAGLRectangularFrame.m
//  a5
//
//  Created by Mark Kim on 3/6/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLRectangularFrame.h"
#import "MAAtlasData.h"
#import "MAAtlasSpriteData.h"
#import "vertex_functions.h"

@implementation MAGLRectangularFrame

- (void)setupBuffer
{
    int numVertices = 6;
    float positions[4][3];      // XYZ
    float texels[4][2];         // UV
    float normals[4][3];        // XYZ
    int faces[2][9];            // PTN PTN PTN
    
    NSString *modelString = nil;
    if (self.spriteData) {
        // assume we need to take into account sprite data
        modelString = positionsTexelsNormalsFaces(self.size, self.layerIndex, [self.atlasData atlasSize], [self.spriteData originalSize],
                                                  [self.spriteData frameRelativeToAtlas], [self.spriteData frameRelativeToSourceSize],
                                                  [self.spriteData isRotated], self.stretchToFit, self.respectSpriteFrame,
                                                  positions, texels, normals, faces);
    } else {
        // assume we just want a square that takes into account size and layerIndex
        CGRect rect = CGRectMake(0.0, 0.0, self.size.width, self.size.height);
        modelString = positionsTexelsNormalsFaces(self.size, self.layerIndex, self.size, self.size,
                                                  rect, rect,
                                                  NO, YES, NO,
                                                  positions, texels, normals, faces);
    }
    //NSLog(@"%@", modelString);
    
    if ([modelString length] > 0) {
        size_t size = numVertices * sizeof(Vertex);
        self.vertices = malloc(size);
        if (self.vertices == NULL) {
            NSLog(@"error: out of memory");
            return;
        }
        populateVertices(numVertices, self.vertices, positions, texels, normals, faces);
        
        if (!glIsBuffer(self.buffer0)) {
            glGenBuffers(1, [self bufferRef0]);
            glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
            glBufferData(GL_ARRAY_BUFFER, size, self.vertices, GL_STATIC_DRAW);
        }
        self.numVertices = numVertices;
    }
}

- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerIndex stretchToFit:(BOOL)stretchToFit respectSpriteFrame:(BOOL)respectSpriteFrame textureAtlas:(GLuint)textureAtlas atlasData:(MAAtlasData *)atlasData spriteName:(NSString *)spriteName
{
    if (self = [super init]) {
        self.size = size;
        self.layerIndex = layerIndex;
        self.stretchToFit = stretchToFit;
        self.respectSpriteFrame = respectSpriteFrame;
        self.texture = textureAtlas;
        self.atlasData = atlasData;
        self.spriteData = [atlasData spriteDataWithSpriteName:spriteName];
    }
    return self;
}

- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerIndex
{
    if (self = [super init]) {
        self.size = size;
        self.layerIndex = layerIndex;
    }
    return self;
}

@end
