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
UIColor* dictWrapColor;
UIColor* dictTabColor;

UIColor* numColor;
UIColor* numTabColor;

UIColor* stringColor;
UIColor* stringTabColor;

UIColor* arrayColor;
UIColor* arrayTabColor;

UIColor* objNameColor;

int debth;
int debthValue;

int tabLevel;
int tabValue;

int pixelCounter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setBackgroundColor:[UIColor blackColor]];

    dictColor = [UIColor colorWithRed:1.0 green:0.50 blue:0.0 alpha:1.0];
    dictWrapColor = [UIColor colorWithRed:1.0 green:0.55 blue:0.0 alpha:1.0];
    dictTabColor = [UIColor colorWithRed:1.0 green:0.45 blue:0.0 alpha:1.0];
    
    stringColor = [UIColor colorWithRed:0.0 green:0.80 blue:0.0 alpha:1.0];
    stringTabColor = [UIColor colorWithRed:0.1 green:0.68 blue:0.0 alpha:1.0];

    numColor = [UIColor colorWithRed:0.573 green:0.35 blue:1.0 alpha:1.0];
    numTabColor = [UIColor colorWithRed:0.47 green:0.25 blue:0.85 alpha:1.0];

    arrayColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.6 alpha:1.0];
    arrayTabColor = [UIColor colorWithRed:0.90 green:0.25 blue:0.5 alpha:1.0];
    
    objNameColor = [UIColor colorWithRed:0.0 green:0.80 blue:0.80 alpha:1.0];
    
    debth = 1;
    debthValue = 35;
    tabLevel = 0;
    tabValue = 60;
    pixelCounter = 0;
    
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

    UITextField* responseObjectName = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, 160, 30)];
    responseObjectName.layer.cornerRadius = 6.0;
    responseObjectName.backgroundColor = objNameColor;
    [responseObjectName setTextAlignment:NSTextAlignmentCenter];
    [responseObjectName setFont:[UIFont systemFontOfSize:15.0 ]];
    [responseObjectName setPlaceholder:@"Set Object Name!"];
    [self.view addSubview:responseObjectName];
    [self.scrollView addSubview:responseObjectName];
    
    treeNode = treeNode.children[0];

    [self buildButtons:treeNode];
    
    self.scrollView.contentSize = CGSizeMake( (tabValue * tabLevel), ((debth + 1) * debthValue) + 40);
    self.scrollView.scrollEnabled = true;
}

-(void) buildButtons:(JNode*)node{
    
    if( [node.type isEqualToString:@"NSDictionary"] ){
        if (![node.name isEqualToString:@"NSDictionary"]){
            debth++;
            
            UIButton* newButton;
            if( node.name.length > 12){
                newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 26)];
            }else{
                newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 26)];
            }

            newButton.backgroundColor = dictColor;
            newButton.layer.cornerRadius = 6.0;
            [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [newButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            
            NSString* str = node.name;
            str = [str capitalizedString];
            [newButton setTitle:str forState:UIControlStateNormal];
            
            UILabel* newLabel = [[UILabel alloc]initWithFrame:CGRectMake((tabValue * tabLevel) + tabValue + 55 , (debth * debthValue) + 29, 14, (35 * node.children.count))];
            newLabel.backgroundColor = dictWrapColor;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];
            
            [self.view addSubview:newButton];
            [self.scrollView addSubview:newButton];
            tabLevel++;
            
            for (int i = 0; i < node.children.count; ++i){
                
                int tempX = tabValue * (tabLevel);
                int tempY = (debth+1) * debthValue;
                [self buildButtons:node.children[i]];
                pixelCounter++;
                UILabel* tabElem = [[UILabel alloc]initWithFrame:CGRectMake(60 + tempX, tempY - 2, 13 + (pixelCounter/2), 28)];
                
                JNode* nextNode = node.children[i];
                if( [nextNode.type isEqualToString:@"NSString"] ){
                    tabElem.backgroundColor = stringTabColor;
                }else if([nextNode.type isEqualToString:@"NSNumber"]){
                    tabElem.backgroundColor = numTabColor;
                }else if([nextNode.type isEqualToString:@"NSArray"]){
                    tabElem.backgroundColor = arrayTabColor;
                }else{
                    tabElem.backgroundColor = dictTabColor;
                }
                
                [self.view addSubview:tabElem];
                [self.scrollView addSubview:tabElem];
            }
            pixelCounter = 0;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];

            tabLevel--;
        }else{
            for (int i = 0; i < node.children.count; ++i){
                [self buildButtons:node.children[i]];
            }
        }
    } else if( [node.type isEqualToString:@"NSArray"]) {

        debth++;
        
        UIButton* newButton;
        if( node.name.length > 12){
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 24)];
        }else{
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 24)];
        }
        
        newButton.backgroundColor = arrayColor;
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString* str = node.name;
        str = [str capitalizedString];
        [newButton setTitle:str forState:UIControlStateNormal];
        [newButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.view addSubview:newButton];
        [self.scrollView addSubview:newButton];
        tabLevel++;
        
        for (int i = 0; i < node.children.count; ++i){
            [self buildButtons:node.children[i]];
        }
        
        tabLevel--;
    } else {
        debth++;
        
        UIButton* newButton;
        if( node.name.length > 12){
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 24)];
        }else{
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(60 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 24)];
        }
        
        if([node.type isEqualToString:@"NSString"] ){
            newButton.backgroundColor = stringColor;
        }else{
            newButton.backgroundColor = numColor;
        }
        
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString* str = node.name;
        str = [str capitalizedString];
        [newButton setTitle:str forState:UIControlStateNormal];
        [newButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.view addSubview:newButton];
        [self.scrollView addSubview:newButton];
    }
}

@end
