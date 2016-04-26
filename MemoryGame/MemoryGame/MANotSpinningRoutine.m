//
//  MANotSpinningRoutine.m
//  a5
//
//  Created by Mark Kim on 2/13/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MANotSpinningRoutine.h"
#import "MAGLWorldObject.h"

@implementation MANotSpinningRoutine

- (void)startWithObject:(id)object userInfo:(NSDictionary *)userInfo
{
    [super startWithObject:object userInfo:userInfo];
    MAGLWorldObject *worldObject = (MAGLWorldObject *)object;
    worldObject.params.degreesRotationJerkX = 0.0;
    worldObject.params.degreesRotationAccelerationX = 0.0;
    worldObject.params.degreesRotationVelocityX = 0.0;
    worldObject.params.degreesRotationJerkY = 0.0;
    worldObject.params.degreesRotationAccelerationY = 0.0;
    worldObject.params.degreesRotationVelocityY = 0.0;
    [self succeed];
}

@end
