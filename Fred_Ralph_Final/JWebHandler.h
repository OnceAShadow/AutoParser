//
//  JWebHandler.h
//  AutoParser
//
//  Created by admin on 4/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JNode;

@interface JWebHandler : NSObject

@property (nonatomic, copy) NSString *webString;

@property (strong, nonatomic) JNode* treeRoot;

- (NSError*) autoParse:(NSString*)urlString;
+ (id)sharedJWebHandler;
    
@end
