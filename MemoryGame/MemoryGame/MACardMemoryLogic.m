//
//  MACardMemoryLogic.m
//  a5

//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MACardMemoryLogic.h"
#import "MAGLCard.h"
#import "MACardFlipForwardRoutine.h"
#import "MACardFlipForwardMatchRoutine.h"
#import "MACardFlipForwardNotMatchRoutine.h"
#import "math_functions.h"

@interface MACardMemoryLogic ()

@property (nonatomic, weak) MAGLCard *firstCard;

@end

@implementation MACardMemoryLogic

- (void)didBeginTouchingWithStartLocation:(CGPoint)startLocation
{
    if ([self.delegate respondsToSelector:@selector(cards)] && [self.delegate respondsToSelector:@selector(originScreenZ)]) {
        
        NSArray *cards = [self.delegate cards];
        float originScreenZ = [self.delegate originScreenZ];
        GLKVector3 directionVector_3d = directionVector3(startLocation, originScreenZ);
        GLKVector3 origin_3d = GLKVector3Make(0.0, 0.0, 0.0);
        
        for (MAGLCard *card in cards) {
            if (![card isActing]) {
                if (!card.isFlipped) {
                    if (isLineIntersectingSimpleRectangle(origin_3d, directionVector_3d, card.params.position, card.size)) {
                        if (!_firstCard) {
                            _firstCard = card;
                            [self _flipCardForward:card];
                        } else {
                            if ([card.symbolName isEqualToString:_firstCard.symbolName]) {
                                [self _flipCardMatch:card otherCard:_firstCard];
                            } else {
                                [self _flipCardNotMatch:card otherCard:_firstCard];
                            }
                            _firstCard = nil;
                        }
                    }
                }
            }
        }
    }
}

- (void)_flipCardMatch:(MAGLCard *)card otherCard:(MAGLCard *)otherCard
{
    MACardFlipForwardMatchRoutine *flipMatchRoutine = [[MACardFlipForwardMatchRoutine alloc] initWithOtherCard:otherCard];
    [card loadAction:flipMatchRoutine];
    [card startActing];
}

- (void)_flipCardNotMatch:(MAGLCard *)card otherCard:(MAGLCard *)otherCard
{
    MACardFlipForwardNotMatchRoutine *flipNotMatchRoutine = [[MACardFlipForwardNotMatchRoutine alloc] initWithOtherCard:otherCard];
    [card loadAction:flipNotMatchRoutine];
    [card startActing];
}

- (void)_flipCardForward:(MAGLCard *)card
{
    MACardFlipForwardRoutine *flipRoutine = [[MACardFlipForwardRoutine alloc] init];
    [card loadAction:flipRoutine];
    [card startActing];
}

@end
