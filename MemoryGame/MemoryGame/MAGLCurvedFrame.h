//
//  MAGLCurvedFrame.h
//  a5
//
//  Created by Mark Kim on 2/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"

@interface MAGLCurvedFrame : MAGLFrame

@property (nonatomic, assign) float maxLength;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) float sectionAngle;
@property (nonatomic, assign) int layerIndex;
@property (nonatomic, assign) BOOL stretchToFit;
@property (nonatomic, assign) BOOL respectSpriteFrame;

- (instancetype)initWithMaxLength:(float)maxLength radius:(float)radius sectionAngle:(float)sectionAngle layerIndex:(int)layerIndex stretchToFit:(BOOL)stretchToFit respectSpriteFrame:(BOOL)respectSpriteFrame textureAtlas:(GLuint)textureAtlas atlasData:(MAAtlasData *)atlasData spriteName:(NSString *)spriteName;

@end
