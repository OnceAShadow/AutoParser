//
//  USGSEarthquakesViewController.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/14/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "USGSEarthquakesViewController.h"

@interface USGSEarthquakesViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation USGSEarthquakesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UITableViewDataSource
#pragma mark - Table view data source
//static tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Available types of cells
    //FavoritesCustomCell_StyleScience
    
    NSString * reuseIdentifier = @"";
    if(indexPath.row == 0){
        reuseIdentifier = @"CustomAPICall_Style1";
        
    }
    else if(indexPath.row == 1){
        
        reuseIdentifier = @"CustomAPICall_Style2";
    }
    else
    {
        reuseIdentifier = @"CustomAPICall_StyleEmpty";
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    return cell;
}


@end


@implementation CustomAPICall_Style1



@end
