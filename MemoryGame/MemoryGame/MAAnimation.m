//
//  MAAnimation.m
//  a5
//
//  Created by Mark Kim on 1/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAAnimation.h"
#import "MAGLFrame.h"
#import "MAFrameCache.h"
#import "MAAnimationConfig.h"

@interface MAAnimation ()

@property (nonatomic, assign) CGFloat perFrameDuration;

@end

@implementation MAAnimation

- (void)_setPerFrameDuration
{
    if ([_frames count] > 0 && _animationDuration >= 0.0) {
        CGFloat frameCount = [_frames count];
        _perFrameDuration = _animationDuration / frameCount;
    }
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
    if (animationDuration >= 0.0) {
        _animationDuration = animationDuration;
    } else {
        NSLog(@"error: animationDuration is invalid: %f", animationDuration);
    }
    [self _setPerFrameDuration];
}

- (void)setFrames:(NSArray<MAGLFrame *> *)frames
{
    for (MAGLFrame *frame in frames) {
        if (![frame isSetup]) {
            NSLog(@"error: a frame was not set up yet; will call setupBuffer");
            [frame setupBuffer];
        }
    }
    _frames = frames;
    [self _setPerFrameDuration];
}

- (MAGLFrame *)_frameWithConfig:(MAAnimationConfig *)config frameNumber:(NSInteger)frameNumber
{
    MAFrameCache *frameCache = [MAFrameCache sharedInstance];
    NSString *spriteName = [NSString stringWithFormat:@"%@%@%ld", [config.baseName length] > 0 ? config.baseName : @"", [config.separator length] > 0 ? config.separator : @"", (long)frameNumber];
    MAGLFrame *frame = [frameCache frameForSpriteName:spriteName];
    if (!frame) {
        NSLog(@"error: could not find frame in frameCache with spriteName: %@", spriteName);
    }
    return frame;
}

- (void)_setupWithConfig:(MAAnimationConfig *)config
{
    // get frameOrder
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    NSArray *frameOrder = config.frameOrder;
    if (!frameOrder) {
        if (config.startingFrame && config.endingFrame) {
            NSMutableArray *tmpFrameOrder = [[NSMutableArray alloc] init];
            NSInteger startingFrame = [config.startingFrame integerValue];
            NSInteger endingFrame = [config.endingFrame integerValue];
            if (startingFrame <= endingFrame) {
                for (NSInteger i=startingFrame; i<= endingFrame; ++i) {
                    [tmpFrameOrder addObject:@(i)];
                }
            } else if (startingFrame > endingFrame) {
                for (NSInteger i=startingFrame; i>= endingFrame; --i) {
                    [tmpFrameOrder addObject:@(i)];
                }
            }
            frameOrder = tmpFrameOrder;
        } else {
            NSLog(@"error: there is not enough information to set frames properly; startingFrame: %@, endingFrame: %@, frameOrder: %@", config.startingFrame.description, config.endingFrame.description, config.frameOrder.description);
        }
    }
    
    // set frames with frameOrder
    if ([frameOrder count] > 0) {
        for (int i=0; i<[frameOrder count]; ++i) {
            NSNumber *frameNumber = frameOrder[i];
            MAGLFrame *frame = [self _frameWithConfig:config frameNumber:[frameNumber integerValue]];
            if (frame) {
                [frames addObject:frame];
            }
        }
    } else {
        NSLog(@"error: frameOrder (%@) count is not greater than 0", frameOrder.description);
    }
    self.frames = frames;
    
    // set animationDuration
    CGFloat perFrameDuration = [config.perFrameDuration floatValue];
    if (perFrameDuration >= 0.0) {
        self.animationDuration = perFrameDuration * [frames count];
    } else {
        NSLog(@"error: perFrameDuration (%f) is not set up properly", perFrameDuration);
    }
}

- (instancetype)initWithConfig:(MAAnimationConfig *)config
{
    if (self = [super init]) {
        [self _setupWithConfig:config];
    }
    return self;
}

@end
