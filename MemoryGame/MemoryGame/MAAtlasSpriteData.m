//
//  MAAtlasSpriteData.m
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAtlasSpriteData.h"
#import "MAAtlasFrame.h"
#import "MAAtlasSize.h"

@implementation MAAtlasSpriteData

- (CGSize)originalSize
{
    return CGSizeMake([_sourceSize.w floatValue], [_sourceSize.h floatValue]);
}

- (CGRect)frameRelativeToSourceSize
{
    return CGRectMake([_spriteSourceSize.x floatValue], [_spriteSourceSize.y floatValue], [_spriteSourceSize.w floatValue], [_spriteSourceSize.h floatValue]);
}

- (CGRect)frameRelativeToAtlas
{
    return CGRectMake([_frame.x floatValue], [_frame.y floatValue], [_frame.w floatValue], [_frame.h floatValue]);
}

- (NSString *)spriteName
{
    // e.g., if filename is "symbol_banana.png", [filenameComponents firstObject] will be "symbol_banana"
    NSArray *filenameComponents = [self.filename componentsSeparatedByString:@"."];
    if ([filenameComponents count] > 2) {
        NSLog(@"error: there are multiple periods in spriteName: %@", self.filename);
    }
    return [filenameComponents firstObject];
}

- (BOOL)isRotated
{
    return [_rotated boolValue];
}

@end
