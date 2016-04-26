//
//  MAAxisDampingRoutine.h
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"

typedef NS_ENUM(NSUInteger, MAAxisType)
{
    kAxisX,
    kAxisY,
    kAxisZ,
};

@interface MAAxisDampingRoutine : MARoutine

- (instancetype)initWithInitialPosOffset:(double)initialPosOffset initialVelocity:(double)initialVelocity maxDampingTime:(NSTimeInterval)maxDampingTime dampingRatio:(double)dampingRatio naturalFrequency:(double)naturalFrequency dampedFrequency:(double)dampedFrequency axis:(MAAxisType)axis;

@end
