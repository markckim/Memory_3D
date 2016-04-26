//
//  MAAccelerationYRoutine.h
//  a5
//
//  Created by Mark Kim on 3/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"

@interface MAAccelerationYRoutine : MARoutine

- (instancetype)initWithStartingDegreesAccelerationY:(double)startingDegreesAccelerationY degreesJerkY:(double)degreesJerkY maxDegreesVelocityY:(double)maxDegreesVelocityY;

@end
