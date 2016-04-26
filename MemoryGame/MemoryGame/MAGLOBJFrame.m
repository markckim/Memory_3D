//
//  MAGLOBJFrame.m
//  a5
//
//  Created by Mark Kim on 3/19/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLOBJFrame.h"

@interface MAGLOBJFrame ()

@end

@implementation MAGLOBJFrame

- (void)setupBuffer
{
    size_t size = self.numVertices * sizeof(Vertex);
    self.vertices = malloc(size);
    for (int i=0; i<self.numVertices; ++i) {
        int xIndex = 3 * i;
        int yIndex = 3 * i + 1;
        int zIndex = 3 * i + 2;
        int uIndex = 2 * i;
        int vIndex = 2 * i + 1;
        Vertex v;
        v.Position[0] = _positions[xIndex];
        v.Position[1] = _positions[yIndex];
        v.Position[2] = _positions[zIndex];
        v.Texel[0] = _texels[uIndex];
        v.Texel[1] = _texels[vIndex];
        v.Normal[0] = _normals[xIndex];
        v.Normal[1] = _normals[yIndex];
        v.Normal[2] = _normals[zIndex];
        self.vertices[i] = v;
    }
    if (!glIsBuffer(self.buffer0)) {
        glGenBuffers(1, [self bufferRef0]);
        glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
        glBufferData(GL_ARRAY_BUFFER, size, self.vertices, GL_STATIC_DRAW);
    }
}

- (instancetype)initWithPositions:(const float[])positions texels:(const float[])texels normals:(const float[])normals numVertices:(int)numVertices
{
    if (self = [super init]) {
        _positions = positions;
        _texels = texels;
        _normals = normals;
        self.numVertices = numVertices;
    }
    return self;
}

@end
