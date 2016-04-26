//
//  routine_functions.m
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "routine_functions.h"
#import "MAGLSprite.h"
#import "MARoutineLoader.h"
#import "MASequence.h"
#import "MAComposite.h"
#import "MADelayRoutine.h"
#import "MAAccelerationXRoutine.h"
#import "MAAccelerationYRoutine.h"
#import "MARotationRoutine.h"
#import "MAParabolicRoutine.h"

MARoutineLoader* r_loader(MAGLSprite *object, MARoutine *action)
{
    MARoutineLoader *routine = [[MARoutineLoader alloc] initWithObject:object action:action];
    return routine;
}

MASequence* r_sequence(NSArray<MARoutine *> *routines)
{
    MASequence *routine = [[MASequence alloc] initWithRoutines:routines];
    return routine;
}

MAComposite* r_composite(NSArray<MARoutine *> *routines)
{
    MAComposite *routine = [[MAComposite alloc] initWithRoutines:routines];
    return routine;
}

MADelayRoutine* r_delay(NSTimeInterval delay)
{
    MADelayRoutine *routine = [[MADelayRoutine alloc] initWithDelay:delay];
    return routine;
}

MAAccelerationXRoutine* r_accelerationX(double startingDegreesAccelerationX, double degreesJerkX, double maxDegreesVelocityX)
{
    MAAccelerationXRoutine *routine = [[MAAccelerationXRoutine alloc] initWithStartingDegreesAccelerationX:startingDegreesAccelerationX degreesJerkX:degreesJerkX maxDegreesVelocityX:maxDegreesVelocityX];
    return routine;
}

MAAccelerationYRoutine* r_accelerationY(double startingDegreesAccelerationY, double degreesJerkY, double maxDegreesVelocityY)
{
    MAAccelerationYRoutine *routine = [[MAAccelerationYRoutine alloc] initWithStartingDegreesAccelerationY:startingDegreesAccelerationY degreesJerkY:degreesJerkY maxDegreesVelocityY:maxDegreesVelocityY];
    return routine;
}

MAAxisDampingRoutine* r_damping(double initialPosOffset, double initialVelocity, NSTimeInterval maxDampingTime, double dampingRatio, double naturalFrequency, double dampedFrequency, MAAxisType axis)
{
    MAAxisDampingRoutine *routine = [[MAAxisDampingRoutine alloc] initWithInitialPosOffset:initialPosOffset initialVelocity:initialVelocity maxDampingTime:maxDampingTime dampingRatio:dampingRatio naturalFrequency:naturalFrequency dampedFrequency:dampedFrequency axis:axis];
    return routine;
}

MARotationRoutine* r_rotation(MAAxisDirection axisDirection, double degreesRotationVelocity, double degreesRotationAmount)
{
    MARotationRoutine *routine = [[MARotationRoutine alloc] initWithAxisDirection:axisDirection degreesRotationVelocity:degreesRotationVelocity degreesRotationAmount:degreesRotationAmount];
    return routine;
}

MAParabolicRoutine* r_parabolic(MAAxisDirection axisDirection, double velocity, double gravity)
{
    MAParabolicRoutine *routine = [[MAParabolicRoutine alloc] initWithAxisDirection:axisDirection velocity:velocity gravity:gravity];
    return routine;
}
