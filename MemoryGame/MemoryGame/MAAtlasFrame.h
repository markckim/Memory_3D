//
//  MAAtlasFrame.h
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MAAtlasFrame : JSONModel

@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *w;
@property (nonatomic, strong) NSNumber *h;

@end
