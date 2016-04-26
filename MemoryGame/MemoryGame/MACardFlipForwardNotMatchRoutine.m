//
//  MACardFlipForwardNotMatchRoutine.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MACardFlipForwardNotMatchRoutine.h"
#import "MAGLCard.h"
#import "MACardFlipBackRoutine.h"
#import "MACardFlipForwardRoutine.h"
#import "routine_functions.h"

@implementation MACardFlipForwardNotMatchRoutine

- (MARoutine *)_cardFlipBack
{
    return [[MACardFlipBackRoutine alloc] init];
}

- (MARoutine *)_cardFlipForward
{
    return [[MACardFlipForwardRoutine alloc] init];
}

- (instancetype)initWithOtherCard:(MAGLCard *)otherCard
{
    if (self = [super init]) {
        [self setRoutines:@[[self _cardFlipForward], r_delay(0.1), r_composite(@[[self _cardFlipBack], r_loader(otherCard, [self _cardFlipBack])])]];
    }
    return self;
}

@end
