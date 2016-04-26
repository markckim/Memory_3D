//
//  MAAnimationCache.h
//  a5
//
//  Created by Mark Kim on 1/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MAAnimation;

@interface MAAnimationCache : NSObject

+ (instancetype)sharedInstance;

- (void)loadAnimation:(MAAnimation *)animation key:(NSString *)key;

- (MAAnimation *)animationWithKey:(NSString *)key;

@end
