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

- (NSError*) autoParse:(NSString*)urlString;

@property (strong, nonatomic) JNode* treeRoot;

+ (id)sharedJWebHandler;
    
@end
