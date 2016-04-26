//
//  routine_functions.h
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAAxisDampingRoutine.h"
#import "math_constants.h"

@class MAGLSprite;
@class MARoutineLoader;
@class MARoutine;
@class MASequence;
@class MAComposite;
@class MADelayRoutine;
@class MAAccelerationXRoutine;
@class MAAccelerationYRoutine;
@class MARotationTravelXRoutine;
@class MARotationTravelYRoutine;
@class MADampingRotationXRoutine;
@class MADampingRotationYRoutine;
@class MARotationRoutine;
@class MAParabolicRoutine;

MARoutineLoader* r_loader(MAGLSprite *object, MARoutine *action);

MASequence* r_sequence(NSArray<MARoutine *> *routines);

MAComposite* r_composite(NSArray<MARoutine *> *routines);

MADelayRoutine* r_delay(NSTimeInterval delay);

MAAccelerationXRoutine* r_accelerationX(double startingDegreesAccelerationX, double degreesJerkX, double maxDegreesVelocityX);

MAAccelerationYRoutine* r_accelerationY(double startingDegreesAccelerationY, double degreesJerkY, double maxDegreesVelocityY);

MAAxisDampingRoutine* r_damping(double initialPosOffset, double initialVelocity, NSTimeInterval maxDampingTime, double dampingRatio, double naturalFrequency, double dampedFrequency, MAAxisType axis);

MARotationTravelXRoutine* r_rotationTravelX(double minimumDegreesTraveled, NSInteger numberOfIndices, NSInteger desiredIndex);

MARotationTravelYRoutine* r_rotationTravelY(double minimumDegreesTraveled, NSInteger numberOfIndices);

MADampingRotationXRoutine* r_dampingRotationX(double rotationPositionOffset, double radius, double degreesRotationVelocity, NSTimeInterval maxDampingTime, double dampingRatio, double naturalFrequency, double dampedFrequency);

MADampingRotationYRoutine* r_dampingRotationY(double rotationPositionOffset, double radius, double degreesRotationVelocity, NSTimeInterval maxDampingTime, double dampingRatio, double naturalFrequency, double dampedFrequency);

MARotationRoutine* r_rotation(MAAxisDirection axisDirection, double degreesRotationVelocity, double degreesRotationAmount);

MAParabolicRoutine* r_parabolic(MAAxisDirection axisDirection, double velocity, double gravity);
