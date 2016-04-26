//
//  MARotationRoutine.h
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"
#import "math_constants.h"

@interface MARotationRoutine : MARoutine

- (instancetype)initWithAxisDirection:(MAAxisDirection)axisDirection degreesRotationVelocity:(float)degreesRotationVelocity degreesRotationAmount:(float)degreesRotationAmount;

@end
