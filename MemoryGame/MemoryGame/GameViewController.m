//
//  GameViewController.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "GameViewController.h"
#import "MAGLCardMemoryController.h"

@interface GameViewController ()

@property (nonatomic, strong) MAGLCardMemoryController *memoryController;

@end

@implementation GameViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touches.anyObject locationInView:self.view];
    [_memoryController didBeginTouchingWithStartLocation:touchPoint];
}

- (void)setupControllers
{
    [super setupControllers];
    _memoryController = [[MAGLCardMemoryController alloc] init];
    [_memoryController setup];
    [self addController:_memoryController];
}

@end
