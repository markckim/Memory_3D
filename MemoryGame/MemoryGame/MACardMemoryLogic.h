//
//  MACardMemoryLogic.h
//  a5
//
//  Created by Mark Kim on 3/10/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLCard.h"

@protocol MACardMemoryLogicDelegate <NSObject>
- (NSArray *)cards;
- (float)originScreenZ;
@end

@interface MACardMemoryLogic : MAObject

@property (nonatomic, weak) id<MACardMemoryLogicDelegate> delegate;

@end
