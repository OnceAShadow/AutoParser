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
NSMutableArray* labels;

UILabel* rootLbl;

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
UIColor* objWrapColor;

int debth;
int debthValue;

int tabLevel;
int tabValue;

int pixelCounter;
int maxTab;

JNode* mainObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.scrollView setBackgroundColor:[UIColor blackColor]];
    
    dictColor = [UIColor colorWithRed:1.0 green:0.40 blue:0.0 alpha:1.0];
    dictWrapColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0];
    dictTabColor = [UIColor colorWithRed:1.0 green:0.32 blue:0.0 alpha:1.0];
    
    stringColor = [UIColor colorWithRed:0.0 green:0.80 blue:0.0 alpha:1.0];
    stringTabColor = [UIColor colorWithRed:0.1 green:0.68 blue:0.0 alpha:1.0];

    numColor = [UIColor colorWithRed:0.573 green:0.35 blue:1.0 alpha:1.0];
    numTabColor = [UIColor colorWithRed:0.47 green:0.25 blue:0.85 alpha:1.0];

    arrayColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.6 alpha:1.0];
    arrayTabColor = [UIColor colorWithRed:0.90 green:0.25 blue:0.5 alpha:1.0];
    
    objNameColor = [UIColor colorWithRed:0.0 green:0.70 blue:0.70 alpha:1.0];
    objWrapColor = [UIColor colorWithRed:0.0 green:0.82 blue:0.82 alpha:1.0];
    
    maxTab = 0;
    debth = -1;
    debthValue = 35;
    tabLevel = -1;
    tabValue = 70;
    pixelCounter = 0;
    
    buttons = [NSMutableArray new];
    JWebHandler *handler  = [JWebHandler sharedJWebHandler];
    
    JNode* treeNode = handler.treeRoot;
    
    bool foundMain = false;
    
    while (!foundMain){
        if( [treeNode.name isEqualToString:@"MainArray"] ){
            foundMain = true;
            mainObj = treeNode;
        }else{
            treeNode = treeNode.children[0];
        }
    }
    NSLog(@"found the main array %@  %@", treeNode.name, treeNode.type);

    treeNode = treeNode.children[0];
    treeNode.name = @"root";
    
    [self buildButtons:treeNode];
    
    maxTab++;
    self.scrollView.contentSize = CGSizeMake( (tabValue * maxTab) + 180, ((debth + 1) * debthValue));
    self.scrollView.scrollEnabled = true;
    
    UIImage* bgimg = [UIImage imageNamed:@"Abstract.jpg"];
    UIImageView* bg = [[UIImageView alloc]initWithFrame:CGRectMake(-300,-100, 1000, 3000)];
    [bg setImage:bgimg];
    bg.alpha = 0.55;
    bg.layer.zPosition = -100;
    [self.scrollView addSubview:bg];
}

-(void) buildButtons:(JNode*)node{
    
    if( [node.type isEqualToString:@"NSDictionary"] ){
        if(![node.name isEqualToString:@"root"]){
            
            debth++;
            UIButton* newButton;
            if( node.name.length > 12){
                newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 24)];
            }else{
                newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 24)];
            }

            newButton.backgroundColor = dictColor;
            newButton.layer.cornerRadius = 6.0;
            [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [newButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            
            [newButton addTarget: self action: @selector(buttonClicked2:) forControlEvents: UIControlEventTouchUpInside];
            
            NSString *firstChar = [node.name substringToIndex:1];
            NSString *result = [[firstChar uppercaseString] stringByAppendingString:[node.name substringFromIndex:1]];
            [newButton setTitle:result forState:UIControlStateNormal];
        
            int lblLenghtX = (tabValue * tabLevel) + tabValue + 55;
            int lblLenghtY = (debth * debthValue) + 23;
            
            [self.view addSubview:newButton];
            [self.scrollView addSubview:newButton];
            tabLevel++;
            
            for (int i = 0; i < node.children.count; ++i){
                
                if(maxTab < tabLevel) maxTab = tabLevel;
                
                int tempX = tabValue * (tabLevel);
                int tempY = (debth+1) * debthValue;
                [self buildButtons:node.children[i]];
                pixelCounter++;
                UILabel* tabElem = [[UILabel alloc]initWithFrame:CGRectMake(80 + tempX, tempY - 2, 13 + (pixelCounter/2), 28)];
                
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
            
            UILabel* newLabel = [[UILabel alloc]initWithFrame:CGRectMake( lblLenghtX + 20 , lblLenghtY, 10, ((debth * debthValue) - lblLenghtY) + 28 )];
            newLabel.backgroundColor = dictWrapColor;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];
            
            pixelCounter = 0;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];

            tabLevel--;
        }else{
            debth++;
            
            UITextField* rootLbl = [[UITextField alloc]initWithFrame:CGRectMake( 64 + (tabValue * tabLevel), (debth * debthValue) - 6, 165, 30)];
            rootLbl.layer.cornerRadius = 6.0;
            rootLbl.backgroundColor = dictColor;
            [rootLbl setTextAlignment:NSTextAlignmentCenter];
            
            [rootLbl setFont:[UIFont systemFontOfSize:15.0]];
            [rootLbl setPlaceholder:@"Set Object Name!"];
            
            [self.view addSubview:rootLbl];
            [self.scrollView addSubview:rootLbl];

            UITextField* responseObjectCover = [[UITextField alloc]initWithFrame:CGRectMake( 58 + (tabValue * tabLevel), (debth * debthValue) - 10, 20, 38)];
            responseObjectCover.backgroundColor = dictTabColor;
            
            [self.view addSubview:responseObjectCover];
            [self.scrollView addSubview:responseObjectCover];
            
            int lblLenghtX = (tabValue * tabLevel) + tabValue + 55;
            int lblLenghtY = (debth * debthValue) + 23;
            
            tabLevel++;
            
            for (int i = 0; i < node.children.count; ++i){
                
                if(maxTab < tabLevel) maxTab = tabLevel;
                
                int tempX = tabValue * (tabLevel);
                int tempY = (debth+1) * debthValue;
                [self buildButtons:node.children[i]];
                pixelCounter++;
                UILabel* tabElem = [[UILabel alloc]initWithFrame:CGRectMake(80 + tempX, tempY - 2, 13 + (pixelCounter/2), 28)];
                
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
            
            UILabel* newLabel = [[UILabel alloc]initWithFrame:CGRectMake( lblLenghtX + 20, lblLenghtY, 13, ((debth * debthValue) - lblLenghtY) + 28 )];
            newLabel.backgroundColor = dictWrapColor;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];
            
            pixelCounter = 0;
            [self.view addSubview:newLabel];
            [self.scrollView addSubview:newLabel];
            
            tabLevel--;
        }
    } else if( [node.type isEqualToString:@"NSArray"]) {

        debth++;
        
        UIButton* newButton;
        if( node.name.length > 12){
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 24)];
        }else{
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 24)];
        }
        
        [newButton addTarget: self action: @selector(buttonClicked:) forControlEvents: UIControlEventTouchUpInside];
        
        newButton.backgroundColor = arrayColor;
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        NSString *firstChar = [node.name substringToIndex:1];
        NSString *result = [[firstChar uppercaseString] stringByAppendingString:[node.name substringFromIndex:1]];
        [newButton setTitle:result forState:UIControlStateNormal];
        
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
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 170 + pixelCounter, 24)];
        }else{
            newButton = [[UIButton alloc]initWithFrame:CGRectMake(80 + (tabValue * tabLevel), (debth * debthValue), 135 + pixelCounter, 24)];
        }
        
        [newButton addTarget: self action: @selector(buttonClicked:) forControlEvents: UIControlEventTouchUpInside];
        
        if([node.type isEqualToString:@"NSString"] ){
            newButton.backgroundColor = stringColor;
        }else{
            newButton.backgroundColor = numColor;
        }
        
        newButton.layer.cornerRadius = 6.0;
        [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        NSString *firstChar = [node.name substringToIndex:1];
        NSString *result = [[firstChar uppercaseString] stringByAppendingString:[node.name substringFromIndex:1]];
        [newButton setTitle:result forState:UIControlStateNormal];
        
        [newButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.view addSubview:newButton];
        [self.scrollView addSubview:newButton];
    }
}

- (IBAction) buttonClicked: (UIButton*)sender{
    if( [sender isSelected] ){
        [sender setSelected:false];
    }else{
        [sender setSelected:true];
    }
}

- (IBAction) buttonClicked2: (UIButton*)sender{
    if( [sender isSelected] ){
        [sender setSelected:false];
    }else{
        [sender setSelected:true];
    }
    // btn check
    // lbl check
    // reload...
}

// btn check

// lbl check

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    mainObj.customName = rootLbl.text;
}

@end
