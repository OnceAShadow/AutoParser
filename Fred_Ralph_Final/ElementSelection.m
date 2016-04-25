//  ElementSelection.m
//  Fred_Ralph_Final
//
//  Created by admin on 4/25/16.
//  Copyright © 2016 MAE. All rights reserved.

#import "ElementSelection.h"
#import "JWebHandler.h"
#import "JNode.h"

@interface ElementSelection ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ElementSelection

NSMutableArray* buttons;
UIColor* dictColor;
UIColor* elemColor;

int debth;
int debthValue;

int tabLevel;
int tabValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setBackgroundColor:[UIColor lightGrayColor]];

    dictColor = [UIColor colorWithRed:1.0 green:0.50 blue:0.50 alpha:1.0];
    elemColor = [UIColor colorWithRed:0.533 green:0.80 blue:0.0 alpha:1.0];
    
    debth = 1;
    debthValue = 35;
    tabLevel = 0;
    tabValue = 60;
    
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
    
    UITextView* responseObjectName = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, 220, 30)];
    responseObjectName.layer.cornerRadius = 6.0;
    responseObjectName.backgroundColor = [UIColor darkGrayColor];
    [responseObjectName setTextAlignment:NSTextAlignmentCenter];
    [responseObjectName setText:@"Name The Response Object"];
    [self.view addSubview:responseObjectName];
    [self.scrollView addSubview:responseObjectName];
    
    treeNode = treeNode.children[0];

    [self buildButtons:treeNode];
    
    self.scrollView.contentSize=CGSizeMake( 800, 1500);
    self.scrollView.scrollEnabled = true;
}

-(void) buildButtons:(JNode*)node{
    //colors: teal, magenta,
    // orange
    
    if( [node.type isEqualToString:@"NSDictionary"] ){
        if (![node.name isEqualToString:@"NSDictionary"]){
            debth++;
            UIButton* newButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + (tabValue * tabLevel), (debth * debthValue), 150, 30)];
            UILabel* newLabel = [[UILabel alloc]initWithFrame:CGRectMake((tabValue * tabLevel) + tabValue, (debth * debthValue) + 25, 25, (35 * node.children.count))];
            newLabel.backgroundColor = dictColor;
            newButton.backgroundColor = dictColor;
            newButton.layer.cornerRadius = 6.0;
            [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [newButton setTitle:node.name forState:UIControlStateNormal];
            
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];
            
            [self.view addSubview:newButton];
            [self.scrollView addSubview:newButton];
            tabLevel++;
            
            for (int i = 0; i < node.children.count; ++i){
                [self buildButtons:node.children[i]];
            }
            
            tabLevel--;
        }else{
            for (int i = 0; i < node.children.count; ++i){
                [self buildButtons:node.children[i]];
            }
        }
    } else if( [node.type isEqualToString:@"NSArray"]) {

        debth++;
        UIButton* newButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + (tabValue * tabLevel), (debth * debthValue), 150, 30)];
        newButton.backgroundColor = [UIColor cyanColor];
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newButton setTitle:node.name forState:UIControlStateNormal];
        [self.view addSubview:newButton];
        [self.scrollView addSubview:newButton];
        tabLevel++;
        
        for (int i = 0; i < node.children.count; ++i){
            [self buildButtons:node.children[i]];
        }
        
        tabLevel--;
    } else {
        debth++;
        UIButton* newButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + (tabValue * tabLevel), (debth * debthValue), 120, 30)];
        newButton.backgroundColor = elemColor;
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newButton setTitle:node.name forState:UIControlStateNormal];
        [self.view addSubview:newButton];
        [self.scrollView addSubview:newButton];
    }
}

@end
