//
//  JNode.m
//  AutoParser
//
//  Created by admin on 4/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "JNode.h"

@implementation JNode

-(instancetype) init{
    self = [super init];
    self.children = [NSMutableArray new];
    return self;
}

-(id)initWithNode:(JNode*)node{
    
    if(node != NULL){
        self.parent = node;
        self.type = @"";
        self.name = @"";
        self.customName = @"";
        self.children = [NSMutableArray new];
    }else{
        self.type = @"root";
        self.name = @"";
        self.customName = @"";
        self.children = [NSMutableArray new];
    }
    
    return self;
}

@end
