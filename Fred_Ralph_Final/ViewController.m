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
#import "JWebHandler.h"

static NSString * const TEST_URL = @"http://api.brewerydb.com/v2/beers/?key=f8db80f96a3647702f68574875e855f0&ibu=10,50";
static NSString * const TEST_URL2 = @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
static NSString * const TEST_URL3 = @"https://api.foursquare.com/v2/venues/search?ll=40.7,-74&oauth_token=ZPCVXWZDKIOMGXIXL4UQBYDZV0I01WN2DCLU50A14L0CZFR3&v=20160423";


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray* earthQuakeList;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[JWebHandler autoParse:TEST_URL];
    
    
}

- (IBAction)btnPrint:(id)sender {
    for( int i = 0; i < self.earthQuakeList.count ; ++i){
        GeoEarthQuake* eq = [self.earthQuakeList objectAtIndex:i];
        NSLog(@"%f", eq.mag );
    }
}

@end
