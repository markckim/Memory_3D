//
//  MAMultiRoutine.h
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"

@interface MAMultiRoutine : MARoutine

- (instancetype)initWithRoutines:(NSArray *)routines;
- (void)setRoutines:(NSArray *)routines;
- (NSArray *)routines;

@end
