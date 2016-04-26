//
//  MAFrameCache.m
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAFrameCache.h"
#import "MAGLFrame.h"
#import "MAAtlasSpriteData.h"

@interface MAFrameCache ()

@property (nonatomic, strong) NSMutableDictionary *frameDict;

@end

@implementation MAFrameCache

+ (instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    // initialize sharedObject as nil (first call only)
    __strong static MAFrameCache *_sharedObject = nil;
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        _sharedObject.frameDict = [[NSMutableDictionary alloc] init];
    });
    // returns the same object each time
    return _sharedObject;
}

- (MAGLFrame *)frameForSpriteName:(NSString *)spriteName
{
    return _frameDict[spriteName];
}

- (void)loadFrame:(MAGLFrame *)frame
{
    [self loadFrame:frame spriteName:nil];
}

- (void)loadFrame:(MAGLFrame *)frame spriteName:(NSString *)spriteName
{
    NSString *key = spriteName;
    if (!(key && [key length] > 0)) {
        key = [frame.spriteData spriteName];
    }
    if ([key length] > 0) {
        if (![frame isSetup]) {
            NSLog(@"warn: frame (%@) is not setup yet; MAFrameCache will call setupBuffer method; then, add to cache", [frame.spriteData spriteName]);
            [frame setupBuffer];
        }
        _frameDict[key] = frame;
    } else {
        NSLog(@"error: MAFrameCache: spriteName is nil");
    }
}

@end
