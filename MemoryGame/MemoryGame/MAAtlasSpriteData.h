//
//  MAAtlasSpriteData.h
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@protocol MAAtlasSpriteData
@end

@class MAAtlasFrame;
@class MAAtlasSize;
@class MAAtlasPoint;

@interface MAAtlasSpriteData : JSONModel

@property (nonatomic, copy) NSString *filename;
@property (nonatomic, strong) MAAtlasFrame *frame;
@property (nonatomic, strong) NSNumber *rotated;
@property (nonatomic, strong) NSNumber *trimmed;
@property (nonatomic, strong) MAAtlasFrame *spriteSourceSize;
@property (nonatomic, strong) MAAtlasSize *sourceSize;
@property (nonatomic, strong) MAAtlasPoint *pivot;

- (CGSize)originalSize;
- (CGRect)frameRelativeToSourceSize;
- (CGRect)frameRelativeToAtlas;
- (NSString *)spriteName;
- (BOOL)isRotated;

@end
