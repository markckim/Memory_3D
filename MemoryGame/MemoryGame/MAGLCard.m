//
//  MAGLCard.m
//  a5
//
//  Created by Mark Kim on 3/7/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLCard.h"

@interface MAGLCard ()

@property (nonatomic, assign) NSTimeInterval elapsedTime;

@end

@implementation MAGLCard

- (void)update:(NSTimeInterval)deltaTime
{
    [super update:deltaTime];
    
    // logic to adjust z offset based on rotationY position
//    double maxZOffset = 1.0;
//    double zOffset = maxZOffset + maxZOffset * sin(_elapsedTime);
//    _elapsedTime += deltaTime;
//    self.params.positionOffset = GLKVector3Make(0.0, 0.0, zOffset);
    
    // front cover
    _frontCover.params.rotationY = self.params.rotationY;
    _frontCover.params.positionOffset = self.params.positionOffset;
    
    // back cover
    _backCover.params.rotationY = 180.0 + self.params.rotationY;
    _backCover.params.positionOffset = self.params.positionOffset;
    
    // front icon
    _frontIcon.params.rotationY = self.params.rotationY;
    _frontIcon.params.positionOffset = self.params.positionOffset;
    
    // back icon
    _backIcon.params.rotationY = 180.0 + self.params.rotationY;
    _backIcon.params.positionOffset = self.params.positionOffset;
    
    // side
    _side.params.rotationY = self.params.rotationY;
    _side.params.positionOffset = self.params.positionOffset;
}

@end
