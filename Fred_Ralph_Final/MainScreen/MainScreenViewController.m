//
//  MainScreenViewController.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/14/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "MainScreenViewController.h"
#import "JWebHandler.h"

@interface MainScreenViewController () <UITextFieldDelegate>{
    NSError *errDownloadParse;
}
@property (weak, nonatomic) IBOutlet UILabel *lblApiTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblAPIDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnUserLogin;
@property (weak, nonatomic) IBOutlet UITextField *UniversalAPIBar;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actParsing;

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}





- (IBAction)userLogin:(UIButton *)sender {
}

- (IBAction)showJSONViewer:(UIButton *)sender {
    
}
- (IBAction)showSuggestAnAPI:(UIButton *)sender {
    
}

- (IBAction)showDonateScene:(UIButton *)sender {
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return true;
}


- (IBAction)continueAction:(UIButton *)sender {
    [self.actParsing setHidden:NO];
    [self.actParsing startAnimating];
    JWebHandler *handler  = [JWebHandler sharedJWebHandler];
    errDownloadParse = [handler autoParse:self.UniversalAPIBar.text];
    
    [self.actParsing startAnimating];
    if(errDownloadParse==nil){
        [self performSegueWithIdentifier:@"displayCustomizableAPIView" sender:nil];
    }
}




#pragma mark -  dismiss keyboard while touching the exterior of the view.

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}





@end
