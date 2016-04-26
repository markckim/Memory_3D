//
//  vertex_functions.m
//  a5
//
//  Created by Mark Kim on 1/2/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "vertex_functions.h"
#import <GLKit/GLKit.h>

void _showContents(int segments, float positions[][3], float texels[][2], float normals[][3], int faces[][9])
{
    int numPositions = 2 * (segments + 1);
    int numTexels = 2 * (segments + 1);
    int numNormals = segments;
    int numFaces = 2 * segments;
    
    for (int i=0; i<numPositions; ++i) {
        NSLog(@"p %f %f %f", positions[i][0], positions[i][1], positions[i][2]);
    }
    NSLog(@"\n");
    
    for (int i=0; i<numTexels; ++i) {
        NSLog(@"t %f %f", texels[i][0], texels[i][1]);
    }
    NSLog(@"\n");
    
    for (int i=0; i<numNormals; ++i) {
        NSLog(@"n %f %f %f", normals[i][0], normals[i][1], normals[i][2]);
    }
    NSLog(@"\n");
    
    for (int i=0; i<numFaces; ++i) {
        NSLog(@"f %d/%d/%d %d/%d/%d %d/%d/%d", faces[i][0], faces[i][1], faces[i][2], faces[i][3], faces[i][4], faces[i][5], faces[i][6], faces[i][7], faces[i][8]);
    }
    NSLog(@"\n");
}

NSString* populateTexels_horizontal(int segments, CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[][2])
{
    // input validation
    if (segments < 0) {
        NSLog(@"something wrong with segments: %d", segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // texels
    float lowerU;
    float upperU;
    float lowerV;
    float upperV;
    if (!isRotated) {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.width) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.height) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    } else {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.height) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.width) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    }
    float diffV = upperV - lowerV;
    float diffU = upperU - lowerU;
    float textureIncrementU = diffU / ((float)segments);
    float textureIncrementV = diffV / ((float)segments);
    for (int i=0; i<(segments+1); ++i) {
        if (!isRotated) {
            // determine u
            float u = upperU - i * textureIncrementU;
            
            // (u, v1)
            float v1 = upperV;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u, v1]];
            int index1 = 2 * i;
            texels[index1][0] = u;
            texels[index1][1] = v1;
            
            // (u, v2)
            float v2 = lowerV;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u, v2]];
            int index2 = 2 * i + 1;
            texels[index2][0] = u;
            texels[index2][1] = v2;
        } else {
            // determine v
            float v = lowerV + i * textureIncrementV;
            
            // (u1, v)
            float u1 = upperU;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u1, v]];
            int index1 = 2 * i;
            texels[index1][0] = u1;
            texels[index1][1] = v;
            
            // (u2, v)
            float u2 = lowerU;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u2, v]];
            int index2 = 2 * i + 1;
            texels[index2][0] = u2;
            texels[index2][1] = v;
        }
    }
    return modelString;
}

NSString* populateTexels_vertical(int segments, CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[][2])
{
    // input validation
    if (segments < 0) {
        NSLog(@"something wrong with segments: %d", segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // texels
    float lowerU;
    float upperU;
    float lowerV;
    float upperV;
    if (!isRotated) {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.width) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.height) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    } else {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.height) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.width) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    }
    float diffV = upperV - lowerV;
    float diffU = upperU - lowerU;
    float textureIncrementU = diffU / ((float)segments);
    float textureIncrementV = diffV / ((float)segments);
    for (int i=0; i<(segments+1); ++i) {
        if (!isRotated) {
            // determine v
            float v = upperV - i * textureIncrementV;
            
            // (u1, v)
            float u1 = lowerU;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u1, v]];
            int index1 = 2 * i;
            texels[index1][0] = u1;
            texels[index1][1] = v;
            
            // (u2, v)
            float u2 = upperU;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u2, v]];
            int index2 = 2 * i + 1;
            texels[index2][0] = u2;
            texels[index2][1] = v;
        } else {
            // determine u
            float u = upperU - i * textureIncrementU;
            
            // (u, v1)
            float v1 = upperV;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u, v1]];
            int index1 = 2 * i;
            texels[index1][0] = u;
            texels[index1][1] = v1;
            
            // (u, v2)
            float v2 = lowerV;
            [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", (float)u, v2]];
            int index2 = 2 * i + 1;
            texels[index2][0] = u;
            texels[index2][1] = v2;
        }
    }
    return modelString;
}

NSString* populateCircularPositionsAndNormals_horizontal(float length, float radius, float sectionAngle, int layerIndex, int segments, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[][3], float normals[][3])
{
    // input validation
    if (length <= 0.0 || radius <= 0.0|| sectionAngle < 0.0 || sectionAngle == 0.0 || sectionAngle > 360.0 || layerIndex < 0 || segments < 0) {
        NSLog(@"something wrong with one or more inputs:\nlength: %f\nradius: %f\nsectionAngle: %f\nlayerIndex: %d\nsegments: %d", length, radius, sectionAngle, layerIndex, segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // positions
    float lowerAngle;
    float upperAngle;
    float lowerY;
    float upperY;
    
    if (!stretchToFit) {
        // width and height allotted by inputs
        float allottedWidth = 2.0 * M_PI * radius * sectionAngle / 360.0;
        float allottedHeight = length;
        float allottedAspectRatio = allottedWidth / allottedHeight;
        
        if (!respectSpriteFrame) {
            float virtualAspectRatio = frameRelativeToSourceSize.size.width / frameRelativeToSourceSize.size.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            lowerAngle = -0.5 * (virtualWidth / allottedWidth) * sectionAngle;
            upperAngle = 0.5 * (virtualWidth / allottedWidth) * sectionAngle;
            lowerY = -0.5 * virtualHeight;
            upperY = 0.5 * virtualHeight;
        } else {
            float virtualAspectRatio = sourceSize.width / sourceSize.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerAngle = (percentX - 0.5) * (virtualWidth / allottedWidth) * sectionAngle;
            upperAngle = ((percentX + percentW) - 0.5) * (virtualWidth / allottedWidth) * sectionAngle;
            lowerY = (0.5 - (percentY + percentH)) * virtualHeight;
            upperY = (0.5 - percentY) * virtualHeight;
        }
    } else {
        if (!respectSpriteFrame) {
            // does not respect the actual frame of the image content
            // respects only the size of the smallest bounds that can be created with the image content
            lowerAngle = -0.5 * sectionAngle;
            upperAngle = 0.5 * sectionAngle;
            lowerY = -0.5 * length;
            upperY = 0.5 * length;
        } else {
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerAngle = (percentX - 0.5) * sectionAngle;
            upperAngle = (percentX + percentW - 0.5) * sectionAngle;
            lowerY = (0.5 - (percentY + percentH)) * length;
            upperY = (0.5 - percentY) * length;
        }
    }
    
    float diffAngle = upperAngle - lowerAngle;
    float angleIncrement = diffAngle / ((float)segments);
    for (int i=0; i<(segments+1); ++i) {
        
        // determine angle
        float angle = upperAngle - i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float z = (radius + 0.01 * layerIndex) * cosf(radians);
        float x = (radius + 0.01 * layerIndex) * sinf(radians);
        
        // (x, y1, z)
        float y1 = upperY;
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x, y1, z];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1][0] = x;
        positions[index1][1] = y1;
        positions[index1][2] = z;
        
        // (x, y2, z)
        float y2 = lowerY;
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x, y2, z];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2][0] = x;
        positions[index2][1] = y2;
        positions[index2][2] = z;
    }
    
    // normals
    float y_n = 0;
    for (int i=0; i<segments; ++i) {
        
        // determine angle
        float angle = upperAngle - (((float)i) + 0.5) * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float z = radius * cosf(radians);
        float x = radius * sinf(radians);
        
        // (x, y_n, z)
        NSString *nextString = [NSString stringWithFormat:@"vn %f %f %f\n", x, y_n, z];
        [modelString appendString:nextString];
        normals[i][0] = x;
        normals[i][1] = y_n;
        normals[i][2] = z;
    }
    
    return modelString;
}

NSString* populateCircularPositionsAndNormals_vertical(float length, float radius, float sectionAngle, int layerIndex, int segments, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[][3], float normals[][3])
{
    // input validation
    if (length <= 0.0 || radius <= 0.0|| sectionAngle < 0.0 || sectionAngle == 0.0 || sectionAngle > 360.0 || layerIndex < 0 || segments < 0) {
        NSLog(@"something wrong with one or more inputs:\nlength: %f\nradius: %f\nsectionAngle: %f\nlayerIndex: %d\nsegments: %d", length, radius, sectionAngle, layerIndex, segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // positions
    float lowerAngle;
    float upperAngle;
    float lowerX;
    float upperX;
    
    if (!stretchToFit) {
        // width and height allotted by inputs
        float allottedWidth = length;
        float allottedHeight = 2 * M_PI * radius * sectionAngle / 360.0;
        float allottedAspectRatio = allottedWidth / allottedHeight;
        
        if (!respectSpriteFrame) {
            float virtualAspectRatio = frameRelativeToSourceSize.size.width / frameRelativeToSourceSize.size.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            lowerAngle = -0.5 * (virtualHeight / allottedHeight) * sectionAngle;
            upperAngle = 0.5 * (virtualHeight / allottedHeight) * sectionAngle;
            lowerX = -0.5 * virtualWidth;
            upperX = 0.5 * virtualWidth;
            
        } else {
            float virtualAspectRatio = sourceSize.width / sourceSize.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerAngle = (0.5 - (percentY + percentH)) * (virtualHeight / allottedHeight) * sectionAngle;
            upperAngle = (0.5 - percentY) * (virtualHeight / allottedHeight) * sectionAngle;
            lowerX = (0.5 - (percentX + percentW)) * (virtualWidth / allottedWidth) * length;
            upperX = (0.5 - percentX) * (virtualWidth / allottedWidth) * length;
        }
    } else {
        if (!respectSpriteFrame) {
            // does not respect the actual frame of the image content
            // respects only the size of the smallest bounds that can be created with the image content
            lowerAngle = -0.5 * sectionAngle;
            upperAngle = 0.5 * sectionAngle;
            lowerX = -0.5 * length;
            upperX = 0.5 * length;
        } else {
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerAngle = (0.5 - (percentY + percentH)) * sectionAngle;
            upperAngle = (0.5 - percentY) * sectionAngle;
            lowerX = (0.5 - (percentX + percentW)) * length;
            upperX = (0.5 - percentX) * length;
        }
    }
    
    float diffAngle = upperAngle - lowerAngle;
    float angleIncrement = diffAngle / ((float)segments);
    for (int i=0; i<(segments+1); ++i) {
        
        // determine angle
        float angle = upperAngle - i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float z = (radius + 0.01 * layerIndex) * cosf(radians);
        float y = (radius + 0.01 * layerIndex) * sinf(radians);
        
        // (x1, y, z)
        float x1 = lowerX;
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x1, y, z];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1][0] = x1;
        positions[index1][1] = y;
        positions[index1][2] = z;
        
        // (x2, y, z)
        float x2 = upperX;
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x2, y, z];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2][0] = x2;
        positions[index2][1] = y;
        positions[index2][2] = z;
    }
    
    // normals
    float x_n = 0;
    for (int i=0; i<segments; ++i) {
        
        // determine angle
        float angle = upperAngle - (((float)i) + 0.5) * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float z = radius * cosf(radians);
        float y = radius * sinf(radians);
        
        // (x_n, y, z)
        NSString *nextString = [NSString stringWithFormat:@"vn %f %f %f\n", x_n, y, z];
        [modelString appendString:nextString];
        normals[i][0] = x_n;
        normals[i][1] = y;
        normals[i][2] = z;
    }
    
    return modelString;
}

NSString* populateTriangleFaceIndices(int segments, int faces[][9])
{
    // input validation
    if (segments < 0) {
        NSLog(@"something wrong with segments: %d", segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *facesString = [[NSMutableString alloc] initWithString:@""];
    int numberOfFaces = 2 * segments;
    for (int i=0; i<numberOfFaces; ++i) {
        
        int v_a = i;
        int vt_a = i;
        int vn_a = i/2;
        
        int v_b = i + 1;
        int vt_b = i + 1;
        int vn_b = i/2;
        
        int v_c = i + 2;
        int vt_c = i + 2;
        int vn_c = i/2;
        
        int final_v_a = v_a;
        int final_vt_a = vt_a;
        int final_vn_a = vn_a;
        
        int final_v_b = (i % 2 == 0) ? v_c : v_b;
        int final_vt_b = (i % 2 == 0) ? vt_c : vt_b;
        int final_vn_b = vn_b;
        
        int final_v_c = (i % 2 == 0) ? v_b : v_c;
        int final_vt_c = (i % 2 == 0) ? vt_b : vt_c;
        int final_vn_c = vn_c;
        
        // checking i % 2 to make sure triangles are created counter clockwise
        NSString *nextString = [NSString stringWithFormat:@"f %d/%d/%d %d/%d/%d %d/%d/%d\n",
                                final_v_a, final_vt_a, final_vn_a,
                                final_v_b, final_vt_b, final_vn_b,
                                final_v_c, final_vt_c, final_vn_c];
        [facesString appendString:nextString];
        faces[i][0] = final_v_a;
        faces[i][1] = final_vt_a;
        faces[i][2] = final_vn_a;
        faces[i][3] = final_v_b;
        faces[i][4] = final_vt_b;
        faces[i][5] = final_vn_b;
        faces[i][6] = final_v_c;
        faces[i][7] = final_vt_c;
        faces[i][8] = final_vn_c;
        
        // NSLog(@"i: %d, position indices: %d %d %d\n", i, final_v_a, final_v_b, final_v_c);
    }
    [modelString appendString:facesString];
    return modelString;
}

NSString* circularPositionsTexelsNormalsFaces_horizontal(float length, float radius, float sectionAngle, int layerIndex, int segments,
                                                         CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame,
                                                         float positions[][3], float texels[][2], float normals[][3], int faces[][9])
{
    // input validation
    if (length <= 0.0 || radius <= 0.0|| sectionAngle < 0.0 || sectionAngle == 0.0 || sectionAngle > 360.0 || layerIndex < 0 || segments < 0) {
        NSLog(@"something wrong with one or more inputs:\nlength: %f\nradius: %f\nsectionAngle: %f\nlayerIndex: %d\nsegments: %d", length, radius, sectionAngle, layerIndex, segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    [modelString appendString:populateCircularPositionsAndNormals_horizontal(length, radius, sectionAngle, layerIndex, segments, sourceSize, frameRelativeToSourceSize, stretchToFit, respectSpriteFrame, positions, normals)];
    [modelString appendString:populateTexels_horizontal(segments, atlasSize, frameRelativeToAtlas, isRotated, texels)];
    [modelString appendString:populateTriangleFaceIndices(segments, faces)];
    return modelString;
}

NSString* populateTexels(CGSize atlasSize, CGRect frameRelativeToAtlas, BOOL isRotated, float texels[4][2])
{
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // texels
    float lowerU;
    float upperU;
    float lowerV;
    float upperV;
    if (!isRotated) {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.width) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.height) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    } else {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.height) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.width) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    }
    
    // horizontal
    if (!isRotated) {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.width) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.height) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    } else {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.height) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.width) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    }
    
    // vertical
    if (!isRotated) {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.width) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.height) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    } else {
        lowerU = frameRelativeToAtlas.origin.x / atlasSize.width;
        upperU = (frameRelativeToAtlas.origin.x + frameRelativeToAtlas.size.height) / atlasSize.width;
        lowerV = 1.0 - (frameRelativeToAtlas.origin.y + frameRelativeToAtlas.size.width) / atlasSize.height;
        upperV = 1.0 - frameRelativeToAtlas.origin.y / atlasSize.height;
    }
    
    if (!isRotated) {
        // upper left corner
        texels[0][0] = lowerU;
        texels[0][1] = upperV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[0][0], texels[0][1]]];
        
        // upper right corner
        texels[1][0] = upperU;
        texels[1][1] = upperV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[1][0], texels[1][1]]];
        
        // lower left corner
        texels[2][0] = lowerU;
        texels[2][1] = lowerV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[2][0], texels[2][1]]];

        // lower right corner
        texels[3][0] = upperU;
        texels[3][1] = lowerV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[3][0], texels[3][1]]];
    } else {
        // upper left corner
        texels[0][0] = upperU;
        texels[0][1] = upperV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[0][0], texels[0][1]]];

        // upper right corner
        texels[1][0] = upperU;
        texels[1][1] = lowerV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[1][0], texels[1][1]]];

        // lower left corner
        texels[2][0] = lowerU;
        texels[2][1] = upperV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[2][0], texels[2][1]]];

        // lower right corner
        texels[3][0] = lowerU;
        texels[3][1] = lowerV;
        [modelString appendString:[NSString stringWithFormat:@"vt %f %f\n", texels[3][0], texels[3][1]]];
    }
    
    return modelString;
}

NSString* populatePositionsAndNormals(CGSize size, int layerIndex, CGSize sourceSize, CGRect frameRelativeToSourceSize, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[4][3], float normals[4][3])
{
    // do stuff
    // input validation
    if (size.width < 0.0 || size.height < 0.0) {
        NSLog(@"something wrong with one or more inputs:\nsize.width: %f\nsize.height: %f\nlayerIndex: %d", size.width, size.height, layerIndex);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    
    // positions
    float lowerX;
    float upperX;
    float lowerY;
    float upperY;
    
    if (!stretchToFit) {
        // width and height allotted by inputs
        float allottedWidth = size.width;
        float allottedHeight = size.height;
        float allottedAspectRatio = allottedWidth / allottedHeight;
        
        if (!respectSpriteFrame) {
            float virtualAspectRatio = frameRelativeToSourceSize.size.width / frameRelativeToSourceSize.size.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            lowerX = -0.5 * virtualWidth;
            upperX = 0.5 * virtualWidth;
            lowerY = -0.5 * virtualHeight;
            upperY = 0.5 * virtualHeight;
        } else {
            float virtualAspectRatio = sourceSize.width / sourceSize.height;
            float virtualWidth = allottedWidth;
            float virtualHeight = allottedHeight;
            if (virtualAspectRatio < allottedAspectRatio) {
                virtualWidth = allottedHeight * virtualAspectRatio;
            } else if (virtualAspectRatio > allottedAspectRatio) {
                virtualHeight = allottedWidth / virtualAspectRatio;
            }
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerX = (percentX - 0.5) * virtualWidth;
            upperX = ((percentX + percentW) - 0.5) * virtualWidth;
            lowerY = (0.5 - (percentY + percentH)) * virtualHeight;
            upperY = (0.5 - percentY) * virtualHeight;
        }
    } else {
        if (!respectSpriteFrame) {
            // does not respect the actual frame of the image content
            // respects only the size of the smallest bounds that can be created with the image content
            lowerX = -0.5 * size.width;
            upperX = 0.5 * size.width;
            lowerY = -0.5 * size.height;
            upperY = 0.5 * size.height;
        } else {
            // offsets determined by the actual frame of the image content
            // assumes frameRelativeToSourceSize is always smaller than sourceSize (which should always be true)
            float percentX = frameRelativeToSourceSize.origin.x / sourceSize.width;
            float percentY = frameRelativeToSourceSize.origin.y / sourceSize.height;
            float percentW = frameRelativeToSourceSize.size.width / sourceSize.width;
            float percentH = frameRelativeToSourceSize.size.height / sourceSize.height;
            lowerX = (percentX - 0.5) * size.width;
            upperX = (percentX + percentW - 0.5) * size.width;
            lowerY = (0.5 - (percentY + percentH)) * size.height;
            upperY = (0.5 - percentY) * size.height;
        }
    }
    
    float z = 0.01 * layerIndex;
    
    // positions
    
    // upper left corner
    positions[0][0] = lowerX;
    positions[0][1] = upperY;
    positions[0][2] = z;
    [modelString appendString:[NSString stringWithFormat:@"v %f %f %f\n", positions[0][0], positions[0][1], positions[0][2]]];
    
    // upper right corner
    positions[1][0] = upperX;
    positions[1][1] = upperY;
    positions[1][2] = z;
    [modelString appendString:[NSString stringWithFormat:@"v %f %f %f\n", positions[1][0], positions[1][1], positions[1][2]]];
    
    // lower left corner
    positions[2][0] = lowerX;
    positions[2][1] = lowerY;
    positions[2][2] = z;
    [modelString appendString:[NSString stringWithFormat:@"v %f %f %f\n", positions[2][0], positions[2][1], positions[2][2]]];
    
    // lower right corner
    positions[3][0] = upperX;
    positions[3][1] = lowerY;
    positions[3][2] = z;
    [modelString appendString:[NSString stringWithFormat:@"v %f %f %f\n", positions[3][0], positions[3][1], positions[3][2]]];
    
    // normals
    
    // upper left corner
    normals[0][0] = 0.0;
    normals[0][1] = 0.0;
    normals[0][2] = 1.0;
    [modelString appendString:[NSString stringWithFormat:@"vn %f %f %f\n", normals[0][0], normals[0][1], normals[0][2]]];

    // upper right corner
    normals[1][0] = 0.0;
    normals[1][1] = 0.0;
    normals[1][2] = 1.0;
    [modelString appendString:[NSString stringWithFormat:@"vn %f %f %f\n", normals[1][0], normals[1][1], normals[1][2]]];
    
    // lower left corner
    normals[2][0] = 0.0;
    normals[2][1] = 0.0;
    normals[2][2] = 1.0;
    [modelString appendString:[NSString stringWithFormat:@"vn %f %f %f\n", normals[2][0], normals[2][1], normals[2][2]]];

    // lower right corner
    normals[3][0] = 0.0;
    normals[3][1] = 0.0;
    normals[3][2] = 1.0;
    [modelString appendString:[NSString stringWithFormat:@"vn %f %f %f\n", normals[3][0], normals[3][1], normals[3][2]]];
    
    return modelString;
}

NSString* positionsTexelsNormalsFaces(CGSize size, int layerIndex, CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame, float positions[4][3], float texels[4][2], float normals[4][3], int faces[2][9])
{
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    [modelString appendString:populatePositionsAndNormals(size, layerIndex, sourceSize, frameRelativeToSourceSize, stretchToFit, respectSpriteFrame, positions, normals)];
    [modelString appendString:populateTexels(atlasSize, frameRelativeToAtlas, isRotated, texels)];
    [modelString appendString:populateTriangleFaceIndices(1, faces)];
    return modelString;
}

NSString* circularPositionsTexelsNormalsFaces_vertical(float length, float radius, float sectionAngle, int layerIndex, int segments,
                                                       CGSize atlasSize, CGSize sourceSize, CGRect frameRelativeToAtlas, CGRect frameRelativeToSourceSize, BOOL isRotated, BOOL stretchToFit, BOOL respectSpriteFrame,
                                                       float positions[][3], float texels[][2], float normals[][3], int faces[][9])
{
    // input validation
    if (length <= 0.0 || radius <= 0.0|| sectionAngle < 0.0 || sectionAngle == 0.0 || sectionAngle > 360.0 || layerIndex < 0 || segments < 0) {
        NSLog(@"something wrong with one or more inputs:\nlength: %f\nradius: %f\nsectionAngle: %f\nlayerIndex: %d\nsegments: %d", length, radius, sectionAngle, layerIndex, segments);
        return nil;
    }
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    [modelString appendString:populateCircularPositionsAndNormals_vertical(length, radius, sectionAngle, layerIndex, segments, sourceSize, frameRelativeToSourceSize, stretchToFit, respectSpriteFrame, positions, normals)];
    [modelString appendString:populateTexels_vertical(segments, atlasSize, frameRelativeToAtlas, isRotated, texels)];
    [modelString appendString:populateTriangleFaceIndices(segments, faces)];
    return modelString;
}

void _showVertices(int numVertices, Vertex* vertices)
{
    for (int i=0; i<numVertices; ++i) {
        Vertex v = vertices[i];
        NSLog(@"\np %f %f %f\nt %f %f\nn: %f %f %f\n\n",
              v.Position[0], v.Position[1], v.Position[2],
              v.Texel[0], v.Texel[1],
              v.Normal[0], v.Normal[1], v.Normal[2]);
    }
}

void _writeVertices(int numVertices, Vertex* vertices)
{
    NSError *error = nil;
    
    NSMutableString *writeString = [[NSMutableString alloc] initWithString:@""];
    for (int i=0; i<numVertices; ++i) {
        Vertex v = vertices[i];
        NSString *vString = [NSString stringWithFormat:@"p %f %f %f\nt %f %f\nn %f %f %f\n\n",
                             v.Position[0], v.Position[1], v.Position[2],
                             v.Texel[0], v.Texel[1],
                             v.Normal[0], v.Normal[1], v.Normal[2]];
        [writeString appendString:vString];
    }
    [writeString writeToFile:@"/Users/markkim/Desktop/testing/testing.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

void populateVertices(int numVertices, Vertex* vertices, float positions[][3], float texels[][2], float normals[][3], int faces[][9])
{    
    for (int i=0; i<(numVertices/3); ++i) {
        
        // position indices
        int vA = faces[i][0];
        int vB = faces[i][3];
        int vC = faces[i][6];
        
        // texel indices
        int vtA = faces[i][1];
        int vtB = faces[i][4];
        int vtC = faces[i][7];
        
        // normal indices
        int vnA = faces[i][2];
        int vnB = faces[i][5];
        int vnC = faces[i][8];
        
        int verticesIndex1 = 3 * i;
        int verticesIndex2 = 3 * i + 1;
        int verticesIndex3 = 3 * i + 2;

        Vertex v1;
        v1.Position[0] = positions[vA][0];
        v1.Position[1] = positions[vA][1];
        v1.Position[2] = positions[vA][2];
        v1.Texel[0] = texels[vtA][0];
        v1.Texel[1] = texels[vtA][1];
        v1.Normal[0] = normals[vnA][0];
        v1.Normal[1] = normals[vnA][1];
        v1.Normal[2] = normals[vnA][2];
        vertices[verticesIndex1] = v1;
        
        Vertex v2;
        v2.Position[0] = positions[vB][0];
        v2.Position[1] = positions[vB][1];
        v2.Position[2] = positions[vB][2];
        v2.Texel[0] = texels[vtB][0];
        v2.Texel[1] = texels[vtB][1];
        v2.Normal[0] = normals[vnB][0];
        v2.Normal[1] = normals[vnB][1];
        v2.Normal[2] = normals[vnB][2];
        vertices[verticesIndex2] = v2;
        
        Vertex v3;
        v3.Position[0] = positions[vC][0];
        v3.Position[1] = positions[vC][1];
        v3.Position[2] = positions[vC][2];
        v3.Texel[0] = texels[vtC][0];
        v3.Texel[1] = texels[vtC][1];
        v3.Normal[0] = normals[vnC][0];
        v3.Normal[1] = normals[vnC][1];
        v3.Normal[2] = normals[vnC][2];
        vertices[verticesIndex3] = v3;
    }
    
    BOOL shouldShow = NO;
    if (shouldShow) {
        _showVertices(numVertices, vertices);
    }
    
    BOOL shouldWrite = NO;
    if (shouldWrite) {
        _writeVertices(numVertices, vertices);
    }
}

NSString* positionsNormalsForRoundedRectangle(CGSize size, int layerIndex, float cornerRadius, int segmentsPerCorner, float positions[][3], float normals[][3])
{
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    float minimumLength = MIN(size.width, size.height);
    float adjustedCornerRadius = MIN(cornerRadius, minimumLength);
    
    float lowerX = adjustedCornerRadius - 0.5 * size.width;
    float upperX = -lowerX;
    float lowerY = adjustedCornerRadius - 0.5 * size.height;
    float upperY = -lowerY;
    
    int indexOffset = 0;
    float x = 0.0;
    float y = 0.0;
    float z = 0.01 * layerIndex;
    float x_n = 0.0;
    float y_n = 0.0;
    float z_n = 1.0;
    
    // center point
    positions[0][0] = x;
    positions[0][1] = y;
    positions[0][2] = z;
    normals[0][0] = x_n;
    normals[0][1] = y_n;
    normals[0][2] = z_n;
    ++indexOffset;
    
    float angle = 0.0;
    float radians = 0.0;
    float angleIncrement = 90.0 / ((float)segmentsPerCorner);
    int offset = 0;
    
    // top right corner (0 degrees to 90 degrees)
    offset = indexOffset;
    angle = 0.0;
    for (int i=offset; i<segmentsPerCorner+offset+1; ++i) {
        radians = GLKMathDegreesToRadians(angle);
        float x = cornerRadius * cosf(radians) + upperX;
        float y = cornerRadius * sinf(radians) + upperY;
        positions[i][0] = x;
        positions[i][1] = y;
        positions[i][2] = z;
        normals[i][0] = x_n;
        normals[i][1] = y_n;
        normals[i][2] = z_n;
        ++indexOffset;
        angle += angleIncrement;
    }
    
    // top left corner
    offset = indexOffset;
    angle = 90.0;
    for (int i=offset; i<segmentsPerCorner+offset+1; ++i) {
        radians = GLKMathDegreesToRadians(angle);
        float x = cornerRadius * cosf(radians) - upperX;
        float y = cornerRadius * sinf(radians) + upperY;
        positions[i][0] = x;
        positions[i][1] = y;
        positions[i][2] = z;
        normals[i][0] = x_n;
        normals[i][1] = y_n;
        normals[i][2] = z_n;
        ++indexOffset;
        angle += angleIncrement;
    }
    
    // bottom left corner
    offset = indexOffset;
    angle = 180.0;
    for (int i=offset; i<segmentsPerCorner+offset+1; ++i) {
        radians = GLKMathDegreesToRadians(angle);
        float x = cornerRadius * cosf(radians) - upperX;
        float y = cornerRadius * sinf(radians) - upperY;
        positions[i][0] = x;
        positions[i][1] = y;
        positions[i][2] = z;
        normals[i][0] = x_n;
        normals[i][1] = y_n;
        normals[i][2] = z_n;
        ++indexOffset;
        angle += angleIncrement;
    }
    
    // bottom right corner
    offset = indexOffset;
    angle = 270.0;
    for (int i=offset; i<segmentsPerCorner+offset+1; ++i) {
        radians = GLKMathDegreesToRadians(angle);
        float x = cornerRadius * cosf(radians) + upperX;
        float y = cornerRadius * sinf(radians) - upperY;
        positions[i][0] = x;
        positions[i][1] = y;
        positions[i][2] = z;
        normals[i][0] = x_n;
        normals[i][1] = y_n;
        normals[i][2] = z_n;
        ++indexOffset;
        angle += angleIncrement;
    }
    
    // wrap around
    positions[indexOffset][0] = positions[1][0];
    positions[indexOffset][1] = positions[1][1];
    positions[indexOffset][2] = positions[1][2];
    normals[indexOffset][0] = normals[1][0];
    normals[indexOffset][1] = normals[1][1];
    normals[indexOffset][2] = normals[1][2];
    ++indexOffset;
    
    // print positions
    for (int i=0; i<indexOffset; ++i) {
        [modelString appendString:[NSString stringWithFormat:@"v %f %f %f\n", positions[i][0], positions[i][1], positions[i][2]]];
    }
    // print normals
    for (int i=0; i<indexOffset; ++i) {
        [modelString appendString:[NSString stringWithFormat:@"vn %f %f %f\n", normals[i][0], normals[i][1], normals[i][2]]];
    }
    
    return modelString;
}

NSString* positionsNormalsForRoundedSide(CGSize size, float cornerRadius, float thicknessZ, int layerIndex, int segmentsPerCorner, int segments, float positions[][3], float normals[][3], int faces[][9])
{
    NSMutableString *modelString = [[NSMutableString alloc] initWithString:@""];
    float minimumLength = MIN(size.width, size.height);
    float adjustedCornerRadius = MIN(cornerRadius, minimumLength);
    
    float lowerX = adjustedCornerRadius - 0.5 * size.width;
    float upperX = -lowerX;
    float lowerY = adjustedCornerRadius - 0.5 * size.height;
    float upperY = -lowerY;
    
    // upper right corner
    int indexOffset = 0;
    int offset = indexOffset;
    float angleIncrement = 90.0 / ((float)segmentsPerCorner);
    for (int i=0; i<(segmentsPerCorner+1); ++i) {
        // determine angle
        float angle = i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float x = (cornerRadius + 0.01 * layerIndex) * cosf(radians) + upperX;
        float y = (cornerRadius + 0.01 * layerIndex) * sinf(radians) + upperY;
        float z1 = -0.5 * thicknessZ;
        float z2 = 0.5 * thicknessZ;
        
        // (x, y, z1)
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z1];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1+offset][0] = x;
        positions[index1+offset][1] = y;
        positions[index1+offset][2] = z1;
        ++indexOffset;

        // (x, y, z2)
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z2];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2+offset][0] = x;
        positions[index2+offset][1] = y;
        positions[index2+offset][2] = z2;
        ++indexOffset;
    }
    
    // upper left corner
    offset = indexOffset;
    for (int i=0; i<(segmentsPerCorner+1); ++i) {
        // determine angle
        float angle = 90.0 + i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float x = (cornerRadius + 0.01 * layerIndex) * cosf(radians) - upperX;
        float y = (cornerRadius + 0.01 * layerIndex) * sinf(radians) + upperY;
        float z1 = -0.5 * thicknessZ;
        float z2 = 0.5 * thicknessZ;
        
        // (x, y, z1)
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z1];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1+offset][0] = x;
        positions[index1+offset][1] = y;
        positions[index1+offset][2] = z1;
        ++indexOffset;

        // (x, y, z2)
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z2];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2+offset][0] = x;
        positions[index2+offset][1] = y;
        positions[index2+offset][2] = z2;
        ++indexOffset;
    }
    
    // lower left corner
    offset = indexOffset;
    for (int i=0; i<(segmentsPerCorner+1); ++i) {
        // determine angle
        float angle = 180.0 + i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float x = (cornerRadius + 0.01 * layerIndex) * cosf(radians) - upperX;
        float y = (cornerRadius + 0.01 * layerIndex) * sinf(radians) - upperY;
        float z1 = -0.5 * thicknessZ;
        float z2 = 0.5 * thicknessZ;
        
        // (x, y, z1)
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z1];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1+offset][0] = x;
        positions[index1+offset][1] = y;
        positions[index1+offset][2] = z1;
        ++indexOffset;
        
        // (x, y, z2)
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z2];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2+offset][0] = x;
        positions[index2+offset][1] = y;
        positions[index2+offset][2] = z2;
        ++indexOffset;
    }
    
    // lower right corner
    offset = indexOffset;
    for (int i=0; i<(segmentsPerCorner+1); ++i) {
        // determine angle
        float angle = 270.0 + i * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float x = (cornerRadius + 0.01 * layerIndex) * cosf(radians) + upperX;
        float y = (cornerRadius + 0.01 * layerIndex) * sinf(radians) - upperY;
        float z1 = -0.5 * thicknessZ;
        float z2 = 0.5 * thicknessZ;
        ++indexOffset;
        
        // (x, y, z1)
        NSString *nextString1 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z1];
        [modelString appendString:nextString1];
        int index1 = 2 * i;
        positions[index1+offset][0] = x;
        positions[index1+offset][1] = y;
        positions[index1+offset][2] = z1;
        
        // (x, y, z2)
        NSString *nextString2 = [NSString stringWithFormat:@"v %f %f %f\n", x, y, z2];
        [modelString appendString:nextString2];
        int index2 = 2 * i + 1;
        positions[index2+offset][0] = x;
        positions[index2+offset][1] = y;
        positions[index2+offset][2] = z2;
        ++indexOffset;
    }
    
    // complete the circle
    
    offset = indexOffset;
    positions[offset][0] = positions[0][0];
    positions[offset][1] = positions[0][1];
    positions[offset][2] = positions[0][2];
    ++indexOffset;
    
    offset = indexOffset;
    positions[offset][0] = positions[1][0];
    positions[offset][1] = positions[1][1];
    positions[offset][2] = positions[1][2];
    ++indexOffset;
    
    // normals
    float z_n = 0;
    angleIncrement = 360.0 / ((float)segments);
    for (int i=0; i<segments; ++i) {
        
        // determine angle
        float angle = (((float)i) + 1.0) * angleIncrement;
        float radians = GLKMathDegreesToRadians(angle);
        float x = cosf(radians);
        float y = sinf(radians);
        
        // (x, y_n, z)
        NSString *nextString = [NSString stringWithFormat:@"vn %f %f %f\n", x, y, z_n];
        [modelString appendString:nextString];
        normals[i][0] = x;
        normals[i][1] = y;
        normals[i][2] = z_n;
    }
    [modelString appendString:populateTriangleFaceIndices(segments, faces)];
    return modelString;
}

void populateVerticesPositionsNormals(int numVertices, Vertex* vertices, float positions[][3], float normals[][3], int faces[][9])
{
    for (int i=0; i<(numVertices/3); ++i) {
        
        // position indices
        int vA = faces[i][0];
        int vB = faces[i][3];
        int vC = faces[i][6];
        
        // texel indices
//        int vtA = faces[i][1];
//        int vtB = faces[i][4];
//        int vtC = faces[i][7];
        
        // normal indices
        int vnA = faces[i][2];
        int vnB = faces[i][5];
        int vnC = faces[i][8];
        
        int verticesIndex1 = 3 * i;
        int verticesIndex2 = 3 * i + 1;
        int verticesIndex3 = 3 * i + 2;
        
        Vertex v1;
        v1.Position[0] = positions[vA][0];
        v1.Position[1] = positions[vA][1];
        v1.Position[2] = positions[vA][2];
        v1.Normal[0] = normals[vnA][0];
        v1.Normal[1] = normals[vnA][1];
        v1.Normal[2] = normals[vnA][2];
        vertices[verticesIndex1] = v1;
        
        Vertex v2;
        v2.Position[0] = positions[vB][0];
        v2.Position[1] = positions[vB][1];
        v2.Position[2] = positions[vB][2];
        v2.Normal[0] = normals[vnB][0];
        v2.Normal[1] = normals[vnB][1];
        v2.Normal[2] = normals[vnB][2];
        vertices[verticesIndex2] = v2;
        
        Vertex v3;
        v3.Position[0] = positions[vC][0];
        v3.Position[1] = positions[vC][1];
        v3.Position[2] = positions[vC][2];
        v3.Normal[0] = normals[vnC][0];
        v3.Normal[1] = normals[vnC][1];
        v3.Normal[2] = normals[vnC][2];
        vertices[verticesIndex3] = v3;
    }
    
    BOOL shouldShow = NO;
    if (shouldShow) {
        _showVertices(numVertices, vertices);
    }
    
    BOOL shouldWrite = NO;
    if (shouldWrite) {
        _writeVertices(numVertices, vertices);
    }
}









































