//
//  OutputManager.m
//  Fred_Ralph_Final
//
//

#import "OutputManager.h"
#import "JNode.h"
#import "JWebHandler.h"






/**
 *  Output Manager Generator (uses the actual delegate to generate all the files in accordance to the outputFormat.
 */
@implementation OutputManager{



}

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



- (NSArray*) generateOutputFiles:(API*)RootModel {

    NSMutableArray *fileArrayForAPI;
    if(self.delegateOutput){
        NSLog(@"Generating output for RootModel: %@", RootModel.apiName);
        
        int files = [self.delegateOutput numberOfExportFiles];
        
        fileArrayForAPI= [NSMutableArray arrayWithCapacity:files ];
        
        for (int i=0; i<files; i++) {
        
            [fileArrayForAPI addObject:[self generateOutputfile:i withName:[_delegateOutput nameForFile:i] andFileType:nil]]; //have the extension of file type alread in the name
        
        }
        
        
    
    }
    
    return fileArrayForAPI;
}



- (NSString*) generateOutputfile:(int)fileNumber withName:(NSString*)fileName andFileType:(NSString*)fileExtension
{
    NSMutableString *stringContentsForFile = [[NSMutableString alloc] init];
    
    //Get the model singleton
    JWebHandler *handler = [JWebHandler sharedJWebHandler];
    
    
    //header for file
    [stringContentsForFile appendString:[self.delegateOutput headerForFile:fileNumber]];
    
    
    
    
    return stringContentsForFile;
    
   
}



             
@end









#pragma mark -
/**
 *  OutputFormatters for each language supported
 */
//Obj-C
@implementation ObjectiveCOutputFormatter

- (int) numberOfExportFiles{
    
    /**
     *  number of files for objective-c output
     * 1: APIHandler.h
     * 2: APIHandler.m
     * 3: APIModel.h
     * 4: APIModel.m
     */
    return 4;
}

- (NSString *) codePropertyForOutputAdapter:(JNode*)value{
    if(value.name && value.type){
        if([value.type isEqualToString:@"NSNumber"]){
        
        }
        
        if([value.type isEqualToString:@"NSNumber"]){
            
        }
    }
    return @"";
}


- (NSString *) bodyForFile:(int) file{
    switch (file) {
        case 0:
            return @"@interface WebHandler : NSObject \n \
                            + (id)sharedWebHandler; \n \
                        @end";
            
            
        case 1:
            return @"@implementation \n \
                    NSURL *url = [NSURL URLWithString:urlString]; \n \
                    NSError* downloadError = nil; \n \
                    NSData* APIJsonData = [NSData dataWithContentsOfURL:url]; \n NSDictionary *root = [NSJSONSerialization JSONObjectWithData:BeerData options:NSJSONReadingAllowFragments error:&error];";
            break;
            
        case 2:
                //build the body with properties for each element
            break;
            
            
        case 3:
            return @" \
                    ";
            break;
            
            
        default:
            break;
    }
    
    return @"";
    
    
    
    
    
    
    

}

- (NSString *) headerForFile:(int)file{

    switch (file) {
        case 0: //API Handler Singleton
            return @"// \
                    //  APIHandler.h \
                    // \
                    //  Created by API CrossRoads \
                    //  Copyright © 2016 MAC. All rights reserved. \
                    // \
                    #import <Foundation/Foundation.h>";
            break;
            
        case 1: //API Handler Singleton
            return @"// \
            //  APIHandler.m \
            // \
            //  Created by API CrossRoads \
            //  Copyright © 2016 MAC. All rights reserved. \
            // \
            #import  \"APIHandler.h\"  ";
            break;
            
        case 2: //API Handler Singleton
            return @"// \
            //  APIModel.h \
            // \
            //  Created by API CrossRoads \
            //  Copyright © 2016 MAC. All rights reserved. \
            // \
            #import <Foundation/Foundation.h>";
            break;
            
        case 3: //API Handler Singleton
            return @"// \
            //  APIModel.m \
            // \
            //  Created by API CrossRoads \
            //  Copyright © 2016 MAC. All rights reserved. \
            // \
            #import \"APIModel.h\" \
            @interface WebHandler : NSObject \n \
            ";
            
            break;
            
        default:
            break;
    }
    
    return @"";
    
}

- (NSString *) footerForFile:(int)file{

    return @" @end";
    
}

- (NSString *) nameForFile:(int)file{

    
    switch (file) {
        case 0:
            return @"APIHandler.h";
            break;
        case 1:
            return @"APIHandler.m";
            break;
            
        case 2:
            return @"APIModel.h";
            break;
        
        case 3:
            return @"APIModel.m";
            break;
            
        default:
            break;
    }
    

    return nil;
}

@end


#pragma mark -
/**
 *  OutputFormatters for each language supported
 */
//Swift
@implementation SwiftOutputFormatter



@end

