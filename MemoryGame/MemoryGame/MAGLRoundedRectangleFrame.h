//
//  MAGLRoundedRectangleFrame.h
//  a5
//
//  Created by Mark Kim on 3/7/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLFrame.h"

@interface MAGLRoundedRectangleFrame : MAGLFrame

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) int layerIndex;

- (instancetype)initWithSize:(CGSize)size layerIndex:(int)layerIndex cornerRadius:(float)cornerRadius;

@end
