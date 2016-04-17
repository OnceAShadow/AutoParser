//
//  ViewController.m
//  Fred_Ralph_Final
//
//  Created by admin on 4/9/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "ViewController.h"
#import "APIWebHandler.h"
#import "GeoEarthQuake.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray* earthQuakeList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.earthQuakeList = [APIWebHandler requestEQList];
}

- (IBAction)btnPrint:(id)sender {
    for( int i = 0; i < self.earthQuakeList.count ; ++i){
        GeoEarthQuake* eq = [self.earthQuakeList objectAtIndex:i];
        NSLog(@"%f", eq.mag );
    }
}

@end
