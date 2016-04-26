//
//  MAAnimation.h
//  a5
//
//  Created by Mark Kim on 1/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAGLFrame;
@class MAAnimationConfig;

@interface MAAnimation : NSObject

@property (nonatomic, strong) NSArray<MAGLFrame *> *frames;

// animationDuration should be >= 0
@property (nonatomic, assign) CGFloat animationDuration;

// if set to 0, then should be interpreted as indefinite
@property (nonatomic, assign) NSUInteger repeatCount;

- (instancetype)initWithConfig:(MAAnimationConfig *)config;

// this will send a valid value when both frames and animationDuration are set
- (CGFloat)perFrameDuration;

@end
