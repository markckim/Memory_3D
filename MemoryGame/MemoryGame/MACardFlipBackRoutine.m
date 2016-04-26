//
//  MACardFlipBackRoutine.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MACardFlipBackRoutine.h"
#import "MAGLCard.h"
#import "routine_functions.h"

@implementation MACardFlipBackRoutine

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLCard *card = (MAGLCard *)object;
    card.isFlipped = NO;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setRoutines:@[r_composite(@[r_parabolic(MAAxixZ, 3.0, -16.0), r_rotation(MAAxisY, -480.0, 180.0)])]];
    }
    return self;
}

@end
