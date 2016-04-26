//
//  MAGLRectangularFrame.h
//  a5
//
//  Created by Mark Kim on 3/6/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"

@class MAAtlasData;

@interface MAGLRectangularFrame : MAGLFrame

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) int layerIndex;
@property (nonatomic, assign) BOOL stretchToFit;
@property (nonatomic, assign) BOOL respectSpriteFrame;

// sets positions, normals, and texels of a rectangle taking into account an image
- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerIndex stretchToFit:(BOOL)stretchToFit respectSpriteFrame:(BOOL)respectSpriteFrame textureAtlas:(GLuint)textureAtlas atlasData:(MAAtlasData *)atlasData spriteName:(NSString *)spriteName;

// sets positions, normals, and texels of a rectangle without taking into account an image
- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerIndex;

@end
