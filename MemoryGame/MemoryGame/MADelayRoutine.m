//
//  MADelayRoutine.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MADelayRoutine.h"

@interface MADelayRoutine ()

@property (nonatomic, assign) NSTimeInterval timeSinceStart;
@property (nonatomic, assign) NSTimeInterval delay;

@end

@implementation MADelayRoutine

- (void)actWithObject:(id)object userInfo:(NSDictionary *)userInfo deltaTime:(NSTimeInterval)deltaTime
{
    if ([self isRunning]) {
        _timeSinceStart += deltaTime;
        if (_timeSinceStart > _delay) {
            _timeSinceStart = _delay;
            [self succeed];
        }
    }
}

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay
{
    if (self = [super init]) {
        _timeSinceStart = 0.0;
        _delay = delay;
    }
    return self;
}

@end
