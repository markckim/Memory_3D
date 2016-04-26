//
//  NSMutableArray+Queue.h
//  a5
//
//  Created by Mark Kim on 1/30/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

- (void)enqueue:(id)item;
- (id)dequeue;
- (id)peek;

@end
