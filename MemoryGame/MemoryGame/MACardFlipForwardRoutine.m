//
//  MACardFlipForwardRoutine.m
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MACardFlipForwardRoutine.h"
#import "MAGLCard.h"
#import "routine_functions.h"

@implementation MACardFlipForwardRoutine

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLCard *card = (MAGLCard *)object;
    card.isFlipped = YES;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setRoutines:@[r_composite(@[r_parabolic(MAAxixZ, 3.5, -19.0), r_rotation(MAAxisY, 480.0, 180.0)])]];
    }
    return self;
}

@end
