//
//  MAGLHorizontalCurvedFrame.m
//  a5
//
//  Created by Mark Kim on 2/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLHorizontalCurvedFrame.h"
#import "MAAtlasData.h"
#import "MAAtlasSpriteData.h"
#import "vertex_functions.h"

@implementation MAGLHorizontalCurvedFrame

- (void)setupBuffer
{
    if (self.maxLength <= 0.0 || self.radius <= 0.0 || self.sectionAngle <= 0.0) {
        NSLog(@"error: length (%f), radius (%f), or sectionAngle (%f) invalid", self.maxLength, self.radius, self.sectionAngle);
        return;
    }
    // allocates one segment per 0.5 degrees
    int segments = 2 * self.sectionAngle;
    
    int numPositions = 2 * (segments + 1);
    int numTexels = 2 * (segments + 1);
    int numNormals = segments;
    int numFaces = 2 * segments;
    int numVertices = 2 * 3 * segments;
    
    float positions[numPositions][3];   // XYZ
    float texels[numTexels][2];         // UV
    float normals[numNormals][3];       // XYZ
    int faces[numFaces][9];             // PTN PTN PTN
    
    NSString *modelString = circularPositionsTexelsNormalsFaces_horizontal(self.maxLength, self.radius, self.sectionAngle, self.layerIndex, segments, [self.atlasData atlasSize], [self.spriteData originalSize],
                                                                           [self.spriteData frameRelativeToAtlas], [self.spriteData frameRelativeToSourceSize], [self.spriteData isRotated], self.stretchToFit, self.respectSpriteFrame,
                                                                           positions, texels, normals, faces);
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

@end
