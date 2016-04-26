//
//  MAGLRoundedRectangleFrame.m
//  a5
//
//  Created by Mark Kim on 3/7/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLRoundedRectangleFrame.h"
#import "vertex_functions.h"

@implementation MAGLRoundedRectangleFrame

- (void)setupBuffer
{
    int segmentsPerCorner = 90;
    int numVertices = 4 * (segmentsPerCorner + 1) + 2;
    float positions[numVertices][3];
    float normals[numVertices][3];
    NSString *modelString = positionsNormalsForRoundedRectangle(self.size, self.layerIndex, self.cornerRadius, segmentsPerCorner, positions, normals);
    //NSLog(@"modelString: \n%@", modelString);
    
    if ([modelString length] > 0) {
        size_t size = numVertices * sizeof(Vertex);
        self.vertices = malloc(size);
        if (self.vertices == NULL) {
            NSLog(@"error: out of memory");
            return;
        }
        for (int i=0; i<numVertices; ++i) {
            Vertex v;
            v.Position[0] = positions[i][0];
            v.Position[1] = positions[i][1];
            v.Position[2] = positions[i][2];
            v.Texel[0] = 0.0;
            v.Texel[1] = 0.0;
            v.Normal[0] = normals[i][0];
            v.Normal[1] = normals[i][1];
            v.Normal[2] = normals[i][2];
            self.vertices[i] = v;
        }
        
        if (!glIsBuffer(self.buffer0)) {
            glGenBuffers(1, [self bufferRef0]);
            glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
            glBufferData(GL_ARRAY_BUFFER, size, self.vertices, GL_STATIC_DRAW);
        }
        self.numVertices = numVertices;
    }
}

- (GLuint)drawMode
{
    return GL_TRIANGLE_FAN;
}

- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerindex cornerRadius:(float)cornerRadius
{
    if (self = [super init]) {
        self.size = size;
        self.layerIndex = layerindex;
        self.cornerRadius = cornerRadius;
    }
    return self;
}

@end
