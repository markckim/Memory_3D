//
//  MAAnimationConfig.h
//  a5
//
//  Created by Mark Kim on 1/26/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MAAnimationConfig : JSONModel

// e.g., in "image1_0", the baseName might be "image1"
@property (nonatomic, copy) NSString<Optional> *baseName;

// e.g., in "image1_0", the separator may be "_"
// e.g., a hyphen "-", or underscore "_", or other potential separator, if any
@property (nonatomic, copy) NSString<Optional> *separator;

// array of NSNumber objects that show the order of frames
// if frameOrder is set, startingFrame and endingFrame will be ignored
// e.g., if the order if "image1_0", "image1_1", "image1_2", "image1_1", frameOrder would be @[@0, @1, @2, @1]
@property (nonatomic, copy) NSArray<Optional> *frameOrder;
@property (nonatomic, strong) NSNumber<Optional> *startingFrame;
@property (nonatomic, strong) NSNumber<Optional> *endingFrame;

// perFrameDuration should be >= 0
@property (nonatomic, strong) NSNumber<Optional> *perFrameDuration;

@end
