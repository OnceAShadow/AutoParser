//
//  MainScreenViewController.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/14/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "MainScreenViewController.h"
#import "JWebHandler.h"

@interface MainScreenViewController () <UITextFieldDelegate>
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

    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    
    return true;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"textFieldDidEndEditing");
    [textField resignFirstResponder];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        JWebHandler *handler  = [JWebHandler sharedJWebHandler];
        NSError * err = [handler autoParse:textField.text];
        [self enableNextAfterParse:err];
    
    });
    
}


- (void) enableNextAfterParse:(NSError *) error{
    if(error!=nil){
        //present alert view modal with the error
        NSInteger errorCode = error.code;
        NSString *stringCode = error.localizedDescription;
        
        NSLog(@"An error ocurred while parsing the URL. Code [%li], Description [%@]", (long)errorCode, stringCode);
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.actParsing stopAnimating];
            [self.btnContinue setHidden:NO];
        });
        
    }

}
- (IBAction)continueAction:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"displayCustomizableAPIView" sender:nil];
}



@end
