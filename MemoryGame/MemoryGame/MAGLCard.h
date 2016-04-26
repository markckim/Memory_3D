//
//  MAGLCard.h
//  a5
//
//  Created by Mark Kim on 3/7/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLSprite.h"

@interface MAGLCard : MAGLSprite

@property (nonatomic, weak) MAGLSprite *frontCover;
@property (nonatomic, weak) MAGLSprite *backCover;
@property (nonatomic, weak) MAGLSprite *frontIcon;
@property (nonatomic, weak) MAGLSprite *backIcon;
@property (nonatomic, weak) MAGLSprite *side;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) BOOL isFlipped;
@property (nonatomic, copy) NSString *symbolName;

@end
