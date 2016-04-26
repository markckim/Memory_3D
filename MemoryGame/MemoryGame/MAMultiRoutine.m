//
//  MAMultiRoutine.m
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAMultiRoutine.h"

@interface MAMultiRoutine ()

@property (nonatomic, strong) NSArray *routines;

@end

@implementation MAMultiRoutine

- (void)setRoutines:(NSArray *)routines
{
    if (![self isRunning]) {
        _routines = routines;
    } else {
        NSLog(@"error: could not set routines because sequence is running");
    }
}

- (instancetype)initWithRoutines:(NSArray *)routines
{
    if (self = [super init]) {
        _routines = routines;
    }
    return self;
}

@end
