//
//  MAAtlasData.m
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAtlasData.h"
#import "MAAtlasMeta.h"
#import "MAAtlasSize.h"
#import "MAAtlasSpriteData.h"

@interface MAAtlasData ()

@property (nonatomic, strong) NSDictionary<Ignore> *spriteDataDict;

@end

@implementation MAAtlasData

- (void)setupSpriteData
{
    NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
    for (MAAtlasSpriteData *spriteData in _frames) {
        NSString *filename = spriteData.filename;
        NSArray *filenameComponents = [filename componentsSeparatedByString:@"."];
        NSString *name = [filenameComponents firstObject];
        if ([name length] > 0) {
            tmpDict[name] = spriteData;
        } else {
            NSLog(@"error: filename is missing for some spriteData");
        }
    }
    _spriteDataDict = tmpDict;
}

- (CGSize)atlasSize
{
    return CGSizeMake([_meta.size.w floatValue], [_meta.size.h floatValue]);
}

- (MAAtlasSpriteData *)spriteDataWithSpriteName:(NSString *)spriteName
{
    if (!_spriteDataDict) {
        NSLog(@"error: spriteDataDict is nil");
        return nil;
    }
    NSArray *filenameComponents = [spriteName componentsSeparatedByString:@"."];
    NSString *name = [filenameComponents firstObject];
    return _spriteDataDict[name];
}

@end
