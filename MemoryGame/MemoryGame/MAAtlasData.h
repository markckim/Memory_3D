//
//  MAAtlasData.h
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MAAtlasSpriteData.h"

@class MAAtlasMeta;

@interface MAAtlasData : JSONModel

@property (nonatomic, strong) NSArray<MAAtlasSpriteData> *frames;
@property (nonatomic, strong) MAAtlasMeta *meta;

- (void)setupSpriteData;
- (CGSize)atlasSize;
- (MAAtlasSpriteData *)spriteDataWithSpriteName:(NSString *)spriteName;

@end
