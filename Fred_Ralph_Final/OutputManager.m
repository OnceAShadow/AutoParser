//
//  OutputManager.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/24/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "OutputManager.h"

@implementation OutputManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)sharedManager {
    static OutputManager *sharedOutputManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOutputManager = [[self alloc] init];
    });
    return sharedOutputManager;
}



- (NSString*)fileWithString:(NSString*)stringContent andFileName:(NSString*)filename{

    NSFileManager *theFileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    if([theFileManager fileExistsAtPath: filePath]){
        //delete the file to make sure we don't
        [theFileManager removeItemAtPath:filePath error:nil];
    
    }
    
    
    NSError *error = nil;
    [stringContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    return filePath;

}



@end
