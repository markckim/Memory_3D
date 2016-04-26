//
//  vertex_constants.h
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#ifndef a5_vertex_constants_h
#define a5_vertex_constants_h

typedef struct {
    float Position[3];
    float Texel[2];
    float Normal[3];
} Vertex;

// 64 x 64 square of vertices, texels, and normals (normals all pointing to (0,0,1))
extern const Vertex SquareVertices64[4096];
extern const unsigned int SquareIndices64[23814];

// 32 x 32 ""
extern const Vertex SquareVertices32[1024];
extern const unsigned int SquareIndices32[5766];

// 16 x 16 ""
extern const Vertex SquareVertices16[256];
extern const unsigned int SquareIndices16[1350];

// 8 x 8 ""
extern const Vertex SquareVertices8[64];

// 4 x 4 ""
extern const Vertex SquareVertices4[16];

// 2 x 2 ""
extern const Vertex SquareVertices2[4];

#endif
