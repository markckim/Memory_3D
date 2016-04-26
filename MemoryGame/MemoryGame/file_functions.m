//
//  file_functions.m
//  a5
//
//  Created by Mark Kim on 3/11/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "file_functions.h"

NSString* retrieveStringFile(NSString *fileName, NSString *fileType)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@.%@", fileName, fileType];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:fullFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:myPathDocs]) {
        NSString *myPathInfo = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([myPathInfo length] > 0) {
            [fileManager copyItemAtPath:myPathInfo toPath:myPathDocs error:NULL];
        }
    }
    NSString *string = [[NSString alloc] initWithContentsOfFile:myPathDocs encoding:NSUTF8StringEncoding error:NULL];
    return string;
}
