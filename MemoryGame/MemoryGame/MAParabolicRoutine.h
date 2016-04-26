//
//  MAParabolicRoutine.h
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"
#import "math_constants.h"

@interface MAParabolicRoutine : MARoutine

- (instancetype)initWithAxisDirection:(MAAxisDirection)axisDirection velocity:(float)velocity gravity:(float)gravity;

@end
