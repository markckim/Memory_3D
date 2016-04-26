//
//  MARoutineLoader.h
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MARoutine.h"

@class MAGLSprite;

@interface MARoutineLoader : MARoutine

- (instancetype)initWithObject:(MAGLSprite *)object action:(MARoutine *)action;

@end
