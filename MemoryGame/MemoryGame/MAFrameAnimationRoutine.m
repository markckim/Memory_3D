//
//  MAFrameAnimationRoutine.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAFrameAnimationRoutine.h"
#import "MAGLWorldObject.h"
#import "MAAnimation.h"

@interface MAFrameAnimationRoutine ()

@property (nonatomic, strong) MAAnimation *animation;
@property (nonatomic, assign) NSTimeInterval accumulatedTime;
@property (nonatomic, assign) NSInteger repeatCount;
@property (nonatomic, assign) NSInteger animationIndex;

@end

@implementation MAFrameAnimationRoutine

- (BOOL)_isRepeatAllowed
{
    return (_animation.repeatCount == 0 || _repeatCount < _animation.repeatCount);
}

- (void)_revertToDefaultFrameWithObject:(id)object
{
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    if (worldObject.frame != worldObject.defaultFrame) {
        worldObject.frame = worldObject.defaultFrame;
    }
}

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        CGFloat perFrameDuration = [_animation perFrameDuration];
        if (_accumulatedTime > perFrameDuration) {
            // determine how much the animationIndex should be incremented
            NSInteger animationIndexIncrement = 0;
            while (_accumulatedTime > perFrameDuration) {
                _accumulatedTime -= perFrameDuration;
                ++animationIndexIncrement;
            }
            _animationIndex += animationIndexIncrement;
            
            // check if animationIndex has gone over the max frame index possible
            // also, use this opportunity to determine if the animation is starting a repeat
            NSInteger totalFrameCount = [_animation.frames count];
            NSInteger maxFrameIndex = totalFrameCount - 1;
            while (_animationIndex > maxFrameIndex) {
                _animationIndex -= totalFrameCount;
                ++_repeatCount;
            }
            
            // if repeats allowed has been exceeded, frame should not change; instead we should succeed at this point
            if ([self _isRepeatAllowed]) {
                // check if frame should be changed
                BOOL shouldChangeFrame = (animationIndexIncrement > 0) && [self _isRepeatAllowed];
                if (shouldChangeFrame) {
                    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
                    MAGLFrame *frame = _animation.frames[_animationIndex];
                    if (frame && frame != worldObject.frame) {
                        worldObject.frame = frame;
                    }
                }
            } else {
                // DDLogDebug(@"succeed with repeat count: %ld", (long)_repeatCount);
                [self succeedWithObject:object userInfo:userInfo];
            }
        }
        _accumulatedTime += deltaTime;
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // LOG_CLASS_AND_METHOD;
    [super startWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.frame = [_animation.frames firstObject];
}

- (void)succeedWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // LOG_CLASS_AND_METHOD;
    [super succeedWithObject:object userInfo:userInfo];
    [self _revertToDefaultFrameWithObject:object];
}

- (void)failWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    // LOG_CLASS_AND_METHOD;
    [super failWithObject:object userInfo:userInfo];
    [self _revertToDefaultFrameWithObject:object];
}

- (instancetype)initWithAnimation:(MAAnimation *)animation
{
    if (self = [super init]) {
        _animation = animation;
        _accumulatedTime = 0.0;
        _repeatCount = 0;
        _animationIndex = 0;
    }
    return self;
}

@end
