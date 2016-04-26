//
//  MAGLRoundedSideFrame.h
//  a5
//
//  Created by Mark Kim on 3/9/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"

@interface MAGLRoundedSideFrame : MAGLFrame

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) int layerIndex;
@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) float thicknessZ;

- (instancetype)initWithSize:(CGSize)size cornerRadius:(float)cornerRadius thicknessZ:(float)thicknessZ layerIndex:(int)layerIndex;

@end
