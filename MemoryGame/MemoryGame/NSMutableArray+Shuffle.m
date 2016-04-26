//
//  NSMutableArray+Shuffle.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"
#import "math_constants.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    u_int32_t count = (u_int32_t)[self count];
    for (int i = 0; i < count; ++i) {
        int randomInt1 = RAND_INT_FROM_TO(0, count - 1);
        int randomInt2 = RAND_INT_FROM_TO(0, count - 1);
        [self exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
}

@end
