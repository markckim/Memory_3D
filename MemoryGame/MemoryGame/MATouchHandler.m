//
//  MATouchHandler.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MATouchHandler.h"

typedef NS_ENUM(NSInteger, MATouchState)
{
    kNotTouching = 0,
    kStoppedTouching = 1,
    kBeganTouching = 2,
    kTouching = 3,
};

@interface MATouchHandler ()

@property (nonatomic, strong) UITouch *currentTouch;
@property (nonatomic, weak) MAObject *selectedObject;
@property (nonatomic, assign) MATouchState touchState;
@property (nonatomic, assign) NSTimeInterval previousTimestamp;
@property (nonatomic, assign) NSTimeInterval p_previousTimestamp;
@property (nonatomic, assign) NSTimeInterval p_p_previousTimestamp;
@property (nonatomic, assign) CGPoint previousTouchLocation;
@property (nonatomic, assign) CGPoint p_previousTouchLocation;
@property (nonatomic, assign) CGPoint p_p_previousTouchLocation;

@end

@implementation MATouchHandler

- (CGVector)_velocityForTimestamp:(NSTimeInterval)timestamp touchLocation:(CGPoint)touchLocation
{
    NSTimeInterval dt = timestamp - _p_p_previousTimestamp;
    return CGVectorMake((touchLocation.x - _p_p_previousTouchLocation.x) / dt, (touchLocation.y - _p_p_previousTouchLocation.y) / dt);
}

- (void)_updateTouchLocation:(CGPoint)touchLocation reset:(BOOL)reset
{
    _p_p_previousTouchLocation = reset ? touchLocation : _p_previousTouchLocation;
    _p_previousTouchLocation = reset ? touchLocation : _previousTouchLocation;
    _previousTouchLocation = touchLocation;
}

- (void)_updateTimestamp:(NSTimeInterval)timestamp reset:(BOOL)reset
{
    _p_p_previousTimestamp = reset ? timestamp : _p_previousTimestamp;
    _p_previousTimestamp = reset ? timestamp : _previousTimestamp;
    _previousTimestamp = timestamp;
}

- (void)_updateWithTouchState:(MATouchState)touchState
                        touch:(UITouch *)touch
                       object:(MAObject *)object
                touchLocation:(CGPoint)touchLocation
{
    _touchState = touchState;
    
    switch (touchState) {
        case kNotTouching: {
            _currentTouch = nil;
            _selectedObject = nil;
            break;
        }
            
        case kStoppedTouching: {
            [_selectedObject didStopTouchingWithFinalPosition:touchLocation velocity:[self _velocityForTimestamp:touch.timestamp touchLocation:touchLocation]];
            [self _updateWithTouchState:kNotTouching touch:touch object:nil touchLocation:touchLocation];
            break;
        }
            
        case kBeganTouching: {
            [object didBeginTouchingWithStartLocation:touchLocation];
            [self _updateTouchLocation:touchLocation reset:YES];
            [self _updateTimestamp:touch.timestamp reset:YES];
            _currentTouch = touch;
            _selectedObject = object;
            break;
        }
            
        case kTouching: {
            [object continueTouchingwithCurrentPosition:touchLocation previousPosition:_previousTouchLocation];
            [self _updateTouchLocation:touchLocation reset:NO];
            [self _updateTimestamp:touch.timestamp reset:NO];
            break;
        }
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches
{
    //DD_LOG_INFO_SELECTOR(_cmd);
    if (_touchState == kNotTouching) {
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInView:_view];
        MAObject *object = [_delegate objectContainingTouchLocation:touchLocation];
        if (object) {
            [self _updateWithTouchState:kBeganTouching touch:touch object:object touchLocation:touchLocation];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches
{
    //DD_LOG_INFO_SELECTOR(_cmd);
    if (_touchState > kStoppedTouching && [touches containsObject:_currentTouch]) {
        CGPoint touchLocation = [_currentTouch locationInView:_view];
        MAObject *object = [_delegate objectContainingTouchLocation:touchLocation];
        if (object && _selectedObject == object) {
            [self _updateWithTouchState:kTouching touch:_currentTouch object:_selectedObject touchLocation:touchLocation];
        } else {
            [self _updateWithTouchState:kStoppedTouching touch:_currentTouch object:nil touchLocation:touchLocation];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches
{
    //DD_LOG_INFO_SELECTOR(_cmd);
    if (_touchState > kStoppedTouching && [touches containsObject:_currentTouch]) {
        CGPoint touchLocation = [_currentTouch locationInView:_view];
        [self _updateWithTouchState:kStoppedTouching touch:_currentTouch object:nil touchLocation:touchLocation];
    }
}

- (void)touchesCancelled:(NSSet *)touches
{
    //DD_LOG_INFO_SELECTOR(_cmd);
    if (_touchState > kStoppedTouching && [touches containsObject:_currentTouch]) {
        CGPoint touchLocation = [_currentTouch locationInView:_view];
        [self _updateWithTouchState:kStoppedTouching touch:_currentTouch object:nil touchLocation:touchLocation];
    }
}

- (instancetype)initWithView:(UIView *)view
{
    if (self = [super init]) {
        _view = view;
        _currentTouch = nil;
        _selectedObject = nil;
        _touchState = kNotTouching;
        _previousTimestamp = 0.0;
        _p_previousTimestamp = 0.0;
        _p_p_previousTimestamp = 0.0;
        _previousTouchLocation = CGPointZero;
        _p_previousTouchLocation = CGPointZero;
        _p_p_previousTouchLocation = CGPointZero;
    }
    return self;
}

- (instancetype)init
{
    if (self = [self initWithView:nil]) {
        
    }
    return self;
}

@end
