//
//  USGSAPICustomizeViewController.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/14/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "USGSAPICustomizeViewController.h"
#import "APIWebHandler.h"
#import "GeoEarthQuake.h"

@interface USGSAPICustomizeViewController ()
@property (nonatomic, strong) NSMutableArray* earthQuakeList;
@end

@implementation USGSAPICustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.earthQuakeList = [APIWebHandler requestEQList];
    
    for( int i = 0; i < self.earthQuakeList.count ; ++i){
        GeoEarthQuake* eq = [self.earthQuakeList objectAtIndex:i];
        NSLog(@"%f", eq.mag );
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnPrint:(id)sender {
    for( int i = 0; i < self.earthQuakeList.count ; ++i){
        GeoEarthQuake* eq = [self.earthQuakeList objectAtIndex:i];
        NSLog(@"%f", eq.mag );
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
