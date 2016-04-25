//
//  JNode.h
//  AutoParser
//
//  Created by admin on 4/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNode : NSObject

-(id) initWithNode: (JNode*)node;
    
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* type;

@property(nonatomic, strong)NSMutableArray* children;
@property(nonatomic, strong)JNode* parent;


@end
