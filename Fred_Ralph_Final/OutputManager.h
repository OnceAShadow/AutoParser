//
//  OutputManager.h
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/24/16.
//  Copyright © 2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "APIManager.h"





/**
 *  Protocol for generating a especific type of output.
 *   the manager uses this contract to build the final files
 */
@protocol APIOutputProtocol


/**
 *  Indicates the total number of files for the outputFormat
 *
 *  @return int numberOfFiles (eg. Obj-c=4)
 */
- (int) numberOfExportFiles;
- (NSString *) codePropertyForOutputAdapter:(APIValue*)value;
- (NSString *) headerForFile:(int)file;
- (NSString *) footerForFile:(int)file;
- (NSString *) nameForFile:(int)file;




@end







@interface OutputManager : NSObject


@property (nonatomic, assign) BOOL coloredHTLMOutput;
@property (nonatomic, weak) id<APIOutputProtocol> delegateOutput;

- (NSString*)fileWithString:(NSString*)stringContent andFileName:(NSString*)filename;



@end




/**
 *  OutputFormatters for each language supported
 */
//Obj-C
@interface ObjectiveCOutputFormatter : NSObject <APIOutputProtocol>


@end

//Swift
@interface SwiftOutputFormatter : NSObject <APIOutputProtocol>


@end



