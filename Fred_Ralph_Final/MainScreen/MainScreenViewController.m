//
//  MainScreenViewController.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/14/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblApiTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblAPIDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnUserLogin;

@end

@implementation MainScreenViewController

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




- (IBAction)userLogin:(UIButton *)sender {
}

- (IBAction)showJSONViewer:(UIButton *)sender {
    
}
- (IBAction)showSuggestAnAPI:(UIButton *)sender {
    
}

- (IBAction)showDonateScene:(UIButton *)sender {
}




@end
