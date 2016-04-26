//
//  MAGLCardMemoryController.m
//  a5
//
//  Created by Mark Kim on 3/6/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLCardMemoryController.h"
#import "MAGLSprite.h"
#import "MAAtlasData.h"
#import "MAFrameCache.h"
#import "MAGLRectangularFrame.h"
#import "MAGLCard.h"
#import "MAGLHelper.h"
#import "UIScreen+ScreenSize.h"
#import "MAGLRoundedRectangleFrame.h"
#import "MAGLRoundedSideFrame.h"
#import "MACardMemoryLogic.h"
#import "MAGameConstants.h"
#import "NSMutableArray+Shuffle.h"
#import "UIScreen+ScreenSize.h"
#import "file_functions.h"
#import "gl_functions.h"
#import "math_functions.h"

@interface MAGLCardMemoryController () <MACardMemoryLogicDelegate>

@property (nonatomic, strong) MAAtlasData *atlasData;
@property (nonatomic, strong) MACardMemoryLogic *logic;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *backCovers;
@property (nonatomic, strong) NSMutableArray *frontCovers;
@property (nonatomic, strong) NSMutableArray *backIcons;
@property (nonatomic, strong) NSMutableArray *frontIcons;
@property (nonatomic, strong) NSMutableArray *sides;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, assign) GLuint worldProgram;
@property (nonatomic, assign) GLuint textureAtlas;
@property (nonatomic, assign) float originScreenZ;

@end

@implementation MAGLCardMemoryController

- (void)dealloc
{
    glDeleteProgram(_worldProgram);
    glDeleteTextures(1, &_textureAtlas);
}

- (void)didBeginTouchingWithStartLocation:(CGPoint)startLocation
{
    [_logic didBeginTouchingWithStartLocation:startLocation];
}

- (void)setupProjections
{
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(MA_WORLD_DEFAULT_VERTICAL_FIELD_OF_VIEW_DEGREES), [UIScreen aspectRatio], 0.1, 30.0);
    _originScreenZ = originScreenZ([UIScreen screenSize], MA_WORLD_DEFAULT_VERTICAL_FIELD_OF_VIEW_DEGREES);
    
    for (MAGLSprite *card in _cards) {
        card.projectionMatrix = _projectionMatrix;
    }
    for (MAGLSprite *sprite in _backCovers) {
        sprite.projectionMatrix = _projectionMatrix;
    }
    for (MAGLSprite *sprite in _frontCovers) {
        sprite.projectionMatrix = _projectionMatrix;
    }
    for (MAGLSprite *sprite in _backIcons) {
        sprite.projectionMatrix = _projectionMatrix;
    }
    for (MAGLSprite *sprite in _frontIcons) {
        sprite.projectionMatrix = _projectionMatrix;
    }
    for (MAGLSprite *sprite in _sides) {
        sprite.projectionMatrix = _projectionMatrix;
    }
}

- (void)renderWithView:(GLKView *)view
{
    [view bindDrawable];
    
    for (MAGLSprite *card in _cards) {
        [card setProgram:_worldProgram userInfo:nil];
        [card render];
    }
    for (MAGLSprite *sprite in _backCovers) {
        [sprite setProgram:_worldProgram userInfo:nil];
        [sprite render];
    }
    for (MAGLSprite *sprite in _frontCovers) {
        [sprite setProgram:_worldProgram userInfo:nil];
        [sprite render];
    }
    for (MAGLSprite *sprite in _backIcons) {
        [sprite setProgram:_worldProgram userInfo:nil];
        [sprite render];
    }
    for (MAGLSprite *sprite in _frontIcons) {
        [sprite setProgram:_worldProgram userInfo:nil];
        [sprite render];
    }
    for (MAGLSprite *sprite in _sides) {
        [sprite setProgram:_worldProgram userInfo:nil];
        [sprite render];
    }
}

- (void)update:(NSTimeInterval)deltaTime
{
    for (MAGLSprite *card in _cards) {
        [card update:deltaTime];
    }
    for (MAGLSprite *sprite in _backCovers) {
        [sprite update:deltaTime];
    }
    for (MAGLSprite *sprite in _frontCovers) {
        [sprite update:deltaTime];
    }
    for (MAGLSprite *sprite in _backIcons) {
        [sprite update:deltaTime];
    }
    for (MAGLSprite *sprite in _frontIcons) {
        [sprite update:deltaTime];
    }
    for (MAGLSprite *sprite in _sides) {
        [sprite update:deltaTime];
    }
}

- (void)_setupPrograms
{
    _worldProgram = [MAGLHelper createProgramWithVertexShaderName:@"WorldVertex2" fragmentShaderName:@"WorldFragment2"];
}

- (void)_setupAtlasData
{
    NSString *atlasContent = retrieveStringFile(@"atlas", @"json");
    NSError *error = nil;
    _atlasData = [[MAAtlasData alloc] initWithString:atlasContent error:&error];
    [_atlasData setupSpriteData];
}

- (void)_setupTextureAtlas
{
    _textureAtlas = glIsTexture(_textureAtlas) ? _textureAtlas : setupTexture(@"atlas.png");
}

- (void)_loadFrameCache
{
    // make sure atlasData is set
    if (!_atlasData) {
        NSLog(@"error: atlasData is nil; cannot load frame cache");
        return;
    }
    
    // get frameCache
    MAFrameCache *frameCache = [MAFrameCache sharedInstance];
    
    // load symbols
    NSArray *spriteNames = @[@"symbol_apple", @"symbol_cherry", @"symbol_peach", @"symbol_banana", @"symbol_grape", @"symbol_lemon", @"symbol_watermelon", @"symbol_bar"];
    for (NSInteger i=0; i<[spriteNames count]; ++i) {
        MAGLRectangularFrame *frame = [[MAGLRectangularFrame alloc] initWithSize:CGSizeMake(1.0, 1.0) layerIndex:1 stretchToFit:NO respectSpriteFrame:YES textureAtlas:_textureAtlas atlasData:_atlasData spriteName:spriteNames[i]];
        [frame setupBuffer];
        [frameCache loadFrame:frame];
    }
    
    // load suits
    NSArray *suitNames = @[@"spades", @"spade_outline", @"clubs", @"diamonds", @"hearts"];
    for (NSInteger i=0; i<[suitNames count]; ++i) {
        MAGLRectangularFrame *frame = [[MAGLRectangularFrame alloc] initWithSize:CGSizeMake(0.5, 0.5) layerIndex:1 stretchToFit:NO respectSpriteFrame:NO textureAtlas:_textureAtlas atlasData:_atlasData spriteName:suitNames[i]];
        [frame setupBuffer];
        [frameCache loadFrame:frame];
    }
    
    // load rounded rectangle
    MAGLRoundedRectangleFrame *roundedFrame = [[MAGLRoundedRectangleFrame alloc] initWithSize:CGSizeMake(1.0, 1.5) layerIndex:0 cornerRadius:0.2];
    [roundedFrame setupBuffer];
    [frameCache loadFrame:roundedFrame spriteName:@"rounded_rect"];
    
    // load edges of a card
    MAGLRoundedSideFrame *sideFrame = [[MAGLRoundedSideFrame alloc] initWithSize:CGSizeMake(1.0, 1.5) cornerRadius:0.2 thicknessZ:0.2 layerIndex:0];
    [sideFrame setupBuffer];
    [frameCache loadFrame:sideFrame spriteName:@"side_frame"];
}

- (void)_setupCards
{
    MAFrameCache *frameCache = [MAFrameCache sharedInstance];
    
    NSArray *xValues = @[@(-2.7), @(-0.9), @(0.9), @(2.7)];
    NSArray *yValues = @[@(-2.0), @(0.0), @(2.0)];
    NSArray *allSymbols = @[@"symbol_apple", @"symbol_cherry", @"symbol_peach", @"symbol_banana", @"symbol_grape", @"symbol_lemon", @"symbol_apple", @"symbol_cherry", @"symbol_peach", @"symbol_banana", @"symbol_grape", @"symbol_lemon"];
    NSMutableArray *orderedSymbols = [[NSMutableArray alloc] initWithArray:allSymbols];
    [orderedSymbols shuffle];
    
    NSInteger spriteIndex = 0;
    for (NSInteger i=0; i<[xValues count]; ++i) {
        for (NSInteger j=0; j<[yValues count]; ++j) {
            
            // position
            GLKVector3 position = GLKVector3Make([xValues[i] floatValue], [yValues[j] floatValue], -8.0);
            
            // front cover (rounded rectangle)
            MAGLRoundedRectangleFrame *roundedFrame = (MAGLRoundedRectangleFrame *)[frameCache frameForSpriteName:@"rounded_rect"];
            MAGLSprite *frontCover = [[MAGLSprite alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:roundedFrame];
            frontCover.color = GLKVector3Make(255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0);
            frontCover.shouldColorAll = true;
            frontCover.params.rotationOffset = GLKVector3Make(0.0, 0.0, 0.1);
            [frontCover setupWithProgram:_worldProgram userInfo:nil];
            [_frontCovers addObject:frontCover];
            
            // back cover (rounded rectangle)
            MAGLSprite *backCover = [[MAGLSprite alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:roundedFrame];
            backCover.color = GLKVector3Make(255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0);
            backCover.shouldColorAll = true;
            backCover.params.rotationOffset = GLKVector3Make(0.0, 0.0, 0.1);
            [backCover setupWithProgram:_worldProgram userInfo:nil];
            [_backCovers addObject:backCover];
            
            // front icon (suit)
            MAGLFrame *patternFrame = [frameCache frameForSpriteName:@"diamonds"];
            MAGLSprite *frontIcon = [[MAGLSprite alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:patternFrame];
            frontIcon.params.rotationOffset = GLKVector3Make(0.0, 0.0, 0.1);
            [frontIcon setupWithProgram:_worldProgram userInfo:nil];
            [_frontIcons addObject:frontIcon];
            
            // back icon (symbol)
            NSInteger adjustedSpriteIndex = spriteIndex % [orderedSymbols count];
            NSString *spriteName = orderedSymbols[adjustedSpriteIndex];
            MAGLFrame *symbolFrame = [frameCache frameForSpriteName:spriteName];
            MAGLSprite *backIcon = [[MAGLSprite alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:symbolFrame];
            backIcon.params.rotationOffset = GLKVector3Make(0.0, 0.0, 0.1);
            [backIcon setupWithProgram:_worldProgram userInfo:nil];
            [_backIcons addObject:backIcon];
            
            // side icon (edges of the card)
            MAGLFrame *sideFrame = [frameCache frameForSpriteName:@"side_frame"];
            MAGLSprite *side = [[MAGLSprite alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:sideFrame];
            side.color = GLKVector3Make(255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0);
            side.shouldColorAll = true;
            side.params.rotationOffset = GLKVector3Make(0.0, 0.0, 0.0);
            [side setupWithProgram:_worldProgram userInfo:nil];
            [_sides addObject:side];
            
            // card
            MAGLCard *card = [[MAGLCard alloc] initWithPosition:position rotationX:0.0 rotationY:0.0 frame:nil];
            card.frontCover = frontCover;
            card.backCover = backCover;
            card.frontIcon = frontIcon;
            card.backIcon = backIcon;
            card.side = side;
            // assumes card is the size of the rounded rectangle that makes up the front and back covers
            card.size = roundedFrame.size;
            card.symbolName = spriteName;
            [_cards addObject:card];
            
            // increment sprite index
            ++spriteIndex;
        }
    }
}

- (void)setup
{
    [self _setupPrograms];
    [self _setupAtlasData];
    [self _setupTextureAtlas];
    [self _loadFrameCache];
    [self _setupCards];
}

- (instancetype)init
{
    if (self = [super init]) {
        _cards = [[NSMutableArray alloc] init];
        _frontCovers = [[NSMutableArray alloc] init];
        _backCovers = [[NSMutableArray alloc] init];
        _frontIcons = [[NSMutableArray alloc] init];
        _backIcons = [[NSMutableArray alloc] init];
        _sides = [[NSMutableArray alloc] init];
        _logic = [[MACardMemoryLogic alloc] init];
        _logic.delegate = self;
    }
    return self;
}

@end
