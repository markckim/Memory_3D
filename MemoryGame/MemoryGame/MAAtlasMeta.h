//
//  MAAtlasMeta.h
//  a5
//
//  Created by Mark Kim on 1/3/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class MAAtlasSize;

@interface MAAtlasMeta : JSONModel

@property (nonatomic, strong) MAAtlasSize *size;

@end
