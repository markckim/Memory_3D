//
//  MAGLOBJFrame.h
//  a5
//
//  Created by Mark Kim on 3/19/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"

@interface MAGLOBJFrame : MAGLFrame

@property (nonatomic, assign) const float *positions;
@property (nonatomic, assign) const float *texels;
@property (nonatomic, assign) const float *normals;

- (instancetype)initWithPositions:(const float[])positions texels:(const float[])texels normals:(const float[])normals numVertices:(int)numVertices;

@end
