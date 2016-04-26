//
//  MAGLRoundedSideFrame.m
//  a5
//
//  Created by Mark Kim on 3/9/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLRoundedSideFrame.h"
#import "vertex_functions.h"

@implementation MAGLRoundedSideFrame

- (void)setupBuffer
{
    int segmentsPerCorner = 90;
    int segments = 4 * (segmentsPerCorner + 1);
    
    int numPositions = 2 * (segments + 1);
    //int numTexels = 2 * (segments + 1);
    int numNormals = segments;
    int numFaces = 2 * segments;
    int numVertices = 2 * 3 * segments;
    
    float positions[numPositions][3];   // XYZ
    //float texels[numTexels][2];         // UV
    float normals[numNormals][3];       // XYZ
    int faces[numFaces][9];             // PTN PTN PTN
    
    NSString *modelString = positionsNormalsForRoundedSide(self.size, self.cornerRadius, self.thicknessZ, self.layerIndex, segmentsPerCorner, segments, positions, normals, faces);
    //NSLog(@"modelString: \n%@", modelString);
    
    if ([modelString length] > 0) {
        size_t size = numVertices * sizeof(Vertex);
        self.vertices = malloc(size);
        if (self.vertices == NULL) {
            NSLog(@"error: out of memory");
            return;
        }
        populateVerticesPositionsNormals(numVertices, self.vertices, positions, normals, faces);
        if (!glIsBuffer(self.buffer0)) {
            glGenBuffers(1, [self bufferRef0]);
            glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
            glBufferData(GL_ARRAY_BUFFER, size, self.vertices, GL_STATIC_DRAW);
        }
        self.numVertices = numVertices;
    }
}

- (instancetype)initWithSize:(CGSize)size cornerRadius:(float)cornerRadius thicknessZ:(float)thicknessZ layerIndex:(int)layerIndex
{
    if (self = [super init]) {
        self.size = size;
        self.cornerRadius = cornerRadius;
        self.thicknessZ = thicknessZ;
        self.layerIndex = layerIndex;
    }
    return self;
}

@end
