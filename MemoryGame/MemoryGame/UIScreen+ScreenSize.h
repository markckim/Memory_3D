//
//  UIScreen+ScreenSize.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ScreenSize)

+ (CGSize)screenSize;

+ (CGFloat)scale;

+ (CGSize)nativeScreenSize;

+ (CGFloat)nativeScale;

+ (CGSize)nativePixelSize;

+ (BOOL)isPortrait;

+ (CGFloat)aspectRatio;

@end
