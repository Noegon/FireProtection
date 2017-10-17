//
//  NGNAuthentificationcontrollerViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNAuthentificationcontrollerViewController.h"
#import "NGNUserAuthentificationManager.h"
#import "NGNApplicationStateManager.h"

@interface NGNAuthentificationcontrollerViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *approoveButton;
@property (strong, nonatomic) IBOutlet UISwitch *rememberUserSessionSwitch;

@property (strong, nonatomic) NGNUserAuthentificationManager *manager;

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender;
- (IBAction)registerButtonTapped:(UIButton *)sender;
- (IBAction)approveButtonTapped:(UIButton *)sender;
- (IBAction)exitLoginButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation NGNAuthentificationcontrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [NGNUserAuthentificationManager sharedInstance];
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return YES;
}
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
    //stub: segue performing
}

- (IBAction)registerButtonTapped:(UIButton *)sender {
    //stub: segue performing
}

- (IBAction)approveButtonTapped:(UIButton *)sender {
    self.manager.login = self.loginTextField.text;
    self.manager.primaryPassword = self.passwordTextField.text;
    self.manager.shouldSaveUserSession = self.rememberUserSessionSwitch.isOn;
    [self.manager logInUserWithCompletionHandler:^{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
}

- (IBAction)exitLoginButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
