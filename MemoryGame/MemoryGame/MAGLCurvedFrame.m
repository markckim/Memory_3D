//
//  MAGLCurvedFrame.m
//  a5
//
//  Created by Mark Kim on 2/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLCurvedFrame.h"
#import "MAAtlasData.h"

@implementation MAGLCurvedFrame

- (instancetype)initWithMaxLength:(float)maxLength radius:(float)radius sectionAngle:(float)sectionAngle layerIndex:(int)layerIndex stretchToFit:(BOOL)stretchToFit respectSpriteFrame:(BOOL)respectSpriteFrame textureAtlas:(GLuint)textureAtlas atlasData:(MAAtlasData *)atlasData spriteName:(NSString *)spriteName
{
    if (self = [super init]) {
        self.maxLength = maxLength;
        self.radius = radius;
        self.sectionAngle = sectionAngle;
        self.layerIndex = layerIndex;
        self.stretchToFit = stretchToFit;
        self.respectSpriteFrame = respectSpriteFrame;
        self.texture = textureAtlas;
        self.atlasData = atlasData;
        self.spriteData = [atlasData spriteDataWithSpriteName:spriteName];
    }
    return self;
}

@end
