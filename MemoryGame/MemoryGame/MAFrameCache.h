//
//  MAFrameCache.h
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MAGLFrame;

@interface MAFrameCache : NSObject

+ (instancetype)sharedInstance;

// spriteName is equivalent to the key used to searfh for the object
- (MAGLFrame *)frameForSpriteName:(NSString *)spriteName;

// the key used will be the spriteName found in MAGLFrame's spriteData property
- (void)loadFrame:(MAGLFrame *)frame;

// the key can be manually set with this method;
// you may use this method if you need to keep track of multiple frame objects that use the same image
// (perhaps, you want to size the same image differently)
- (void)loadFrame:(MAGLFrame *)frame spriteName:(NSString *)spriteName;

@end
