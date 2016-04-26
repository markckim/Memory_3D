//
//  math_constants.h
//  a5
//
//  Created by Mark Kim on 1/23/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ARC4RANDOM_MAX 0x100000000

#define RAND_INT_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

#define RAND_DOUBLE_FROM_TO(min, max) ((double)min + floorf(((double)arc4random() / ARC4RANDOM_MAX) * ((double)max - (double)min)))

#define CLAMP(x, low, high) ({\
__typeof__(x) __x = (x); \
__typeof__(low) __low = (low);\
__typeof__(high) __high = (high);\
__x > __high ? __high : (__x < __low ? __low : __x);\
})

typedef NS_ENUM(NSInteger, MAAxisDirection)
{
    MAAxisX,
    MAAxisY,
    MAAxixZ,
};
