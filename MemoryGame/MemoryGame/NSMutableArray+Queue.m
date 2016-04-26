//
//  NSMutableArray+Queue.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (void)enqueue:(id)item
{
    [self addObject:item];
}

- (id)dequeue
{
    id item = nil;
    if ([self count] != 0) {
        item = [self firstObject];
        [self removeObjectAtIndex:0];
    }
    return item;
}

- (id)peek
{
    id item = nil;
    if ([self count] != 0) {
        item = [self firstObject];
    }
    return item;
}

@end
