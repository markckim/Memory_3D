//
//  MAAnimationCache.m
//  a5
//
//  Created by Mark Kim on 1/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAnimationCache.h"

@interface MAAnimationCache ()

@property (nonatomic, strong) NSMutableDictionary *animationDict;

@end

@implementation MAAnimationCache

+ (instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    // initialize sharedObject as nil (first call only)
    __strong static MAAnimationCache *_sharedObject = nil;
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        _sharedObject.animationDict = [[NSMutableDictionary alloc] init];
    });
    // returns the same object each time
    return _sharedObject;
}

- (void)loadAnimation:(MAAnimation *)animation key:(NSString *)key
{
    if (animation && [key length] > 0) {
        _animationDict[key] = animation;
    } else {
        NSLog(@"error: could not load animation (%@) with key (%@)", animation, key);
    }
}

- (MAAnimation *)animationWithKey:(NSString *)key
{
    MAAnimation *animation = nil;
    if ([key length] > 0) {
        animation = _animationDict[key];
    } else {
        NSLog(@"error: key is nil");
    }
    if (!animation) {
        NSLog(@"error: no animation object found for key: %@", key);
    }
    return animation;
}

@end
