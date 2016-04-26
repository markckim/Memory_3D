//
//  vertex_functions.h
//  a5
//
//  Created by Mark Kim on 1/2/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vertex_constants.h"

// positions, texels, normals, and faces are empty; they will become populated with data when this method is run
// if isRotated is YES, the image has been rotated 90 degrees clockwise

// vertically curved
NSString* circularPositionsTexelsNormalsFaces_vertical(float length, float radius, float sectionAngle, int layerIndex, int segments,
                                                       CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame,
                                                       float positions[][3], float texels[][2], float normals[][3], int faces[][9]);
NSString* populateCircularPositionsAndNormals_vertical(float length, float radius, float sectionAngle, int layerIndex, int segments, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[][3], float normals[][3]);
NSString* populateTexels_vertical(int segments, CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[][2]);

// horizontally curved
NSString* circularPositionsTexelsNormalsFaces_horizontal(float length, float radius, float sectionAngle, int layerIndex, int segments,
                                                         CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame,
                                                         float positions[][3], float texels[][2], float normals[][3], int faces[][9]);
NSString* populateCircularPositionsAndNormals_horizontal(float length, float radius, float sectionAngle, int layerIndex, int segments, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[][3], float normals[][3]);
NSString* populateTexels_horizontal(int segments, CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[][2]);

// rectangular
NSString* positionsTexelsNormalsFaces(CGSize size, int layerIndex, CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[4][3], float texels[4][2], float normals[4][3], int faces[2][9]);
NSString* populatePositionsAndNormals(CGSize size, int layerIndex, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[4][3], float normals[4][3]);
NSString* populateTexels(CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[4][2]);

// populating vertices
// assumes GL_TRIANGLES
NSString* populateTriangleFaceIndices(int segments, int faces[][9]);
// assumes GL_TRIANGLES
void populateVertices(int numVertices, Vertex* vertices, float positions[][3], float texels[][2], float normals[][3], int faces[][9]);

// rounded rectangle
NSString* positionsNormalsForRoundedRectangle(CGSize size, int layerIndex, float cornerRadius, int segmentsPerCorner, float positions[][3], float normals[][3]);

// rounded side
NSString* positionsNormalsForRoundedSide(CGSize size, float cornerRadius, float thicknessZ, int layerIndex, int segmentsPerCorner, int segments, float positions[][3], float normals[][3], int faces[][9]);
void populateVerticesPositionsNormals(int numVertices, Vertex* vertices, float positions[][3], float normals[][3], int faces[][9]);
