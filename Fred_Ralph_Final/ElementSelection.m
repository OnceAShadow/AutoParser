//  ElementSelection.m
//  Fred_Ralph_Final
//
//  Created by admin on 4/25/16.
//  Copyright © 2016 MAE. All rights reserved.

#import "ElementSelection.h"
#import "JWebHandler.h"
#import "JNode.h"

@interface ElementSelection ()

@end

@implementation ElementSelection

NSMutableArray* buttons;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    buttons = [NSMutableArray new];
    JWebHandler *handler  = [JWebHandler sharedJWebHandler];
    
    JNode* treeNode = handler.treeRoot;
    
    bool foundMain = false;
    
    while (!foundMain){
        if( [treeNode.name isEqualToString:@"MainArray"] ){
            foundMain = true;
        }else{
            treeNode = treeNode.children[0];
        }
    }
    NSLog(@"found the main array %@  %@", treeNode.name, treeNode.type);
    
    UITextView* responseObjectName = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, 220, 40)];
    responseObjectName.backgroundColor = [UIColor orangeColor];
    [responseObjectName setText:@"Name The Response Object"];
    [self.view addSubview:responseObjectName];
    
    JNode* saveTopNode = treeNode;
    treeNode = treeNode.children[0];
    bool finishTree = false;
    
    while (!finishTree){
        UIButton* newButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 80, 100, 40)];
        newButton.backgroundColor = [UIColor greenColor];
        [newButton setTitle:treeNode.type forState:UIControlStateNormal];
        
        
        [self.view addSubview:newButton];
       
        finishTree = true;
    }
    
}


@end
