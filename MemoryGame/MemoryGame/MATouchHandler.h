//
//  MATouchHandler.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"

@protocol MATouchHandlerDelegate <NSObject>
- (MAObject *)objectContainingTouchLocation:(CGPoint)touchLocation;
@end

@interface MATouchHandler : MAObject

@property (nonatomic, weak) id<MATouchHandlerDelegate> delegate;
@property (nonatomic, weak) UIView *view;

- (instancetype)initWithView:(UIView *)view;
- (void)touchesBegan:(NSSet *)touches;
- (void)touchesMoved:(NSSet *)touches;
- (void)touchesEnded:(NSSet *)touches;
- (void)touchesCancelled:(NSSet *)touches;

@end
