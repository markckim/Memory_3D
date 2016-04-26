//
//  MACardFlipForwardNotMatchRoutine.h
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MASequence.h"

@class MAGLCard;

@interface MACardFlipForwardNotMatchRoutine : MASequence

- (instancetype)initWithOtherCard:(MAGLCard *)otherCard;

@end
