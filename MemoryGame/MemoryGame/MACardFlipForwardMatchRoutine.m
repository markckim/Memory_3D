//
//  MACardFlipForwardMatchRoutine.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MACardFlipForwardMatchRoutine.h"
#import "MAGLCard.h"
#import "MACardFlipForwardRoutine.h"

@implementation MACardFlipForwardMatchRoutine

- (MARoutine *)_cardFlipForward
{
    return [[MACardFlipForwardRoutine alloc] init];
}

- (instancetype)initWithOtherCard:(MAGLCard *)otherCard
{
    if (self = [super init]) {
        [self setRoutines:@[[self _cardFlipForward]]];
    }
    return self;
}


@end
