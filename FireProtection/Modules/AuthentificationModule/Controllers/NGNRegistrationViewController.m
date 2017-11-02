//
//  NGNRegistrationViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNRegistrationViewController.h"
#import "NGNUserAuthentificationManager.h"
#import "NGNRegexMatchUtil.h"

@interface NGNRegistrationViewController ()

@property (strong, nonatomic) NGNUserAuthentificationManager *manager;
@property (strong, nonatomic) NGNRegexMatchUtil *regexMatchUtil;

@property (assign, nonatomic, getter=isLoginValid) BOOL loginValid;
@property (assign, nonatomic, getter=isPasswordValid) BOOL passwordValid;
@property (assign, nonatomic, getter=isRepeatPasswordValid) BOOL repeatPasswordValid;

@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)passwordValueChanged:(UITextField *)sender;
- (IBAction)repeatPasswordValueChanged:(UITextField *)sender;
- (IBAction)registerButtonTapped:(UIButton *)sender;
- (IBAction)loginTextFieldChanged:(UITextField *)sender;

@end

@implementation NGNRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginTextField becomeFirstResponder];
    self.manager = NGNUserAuthentificationManager.sharedInstance;
    self.regexMatchUtil = [[NGNRegexMatchUtil alloc] init];
    self.registerButton.enabled = NO;
    [self.registerButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateDisabled];
    [self.registerButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
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

- (void)setLoginValid:(BOOL) newValue {
    _loginValid = newValue;
    [self checkAndToggleRegisterButton];
}

- (void)setPasswordValid:(BOOL) newValue {
    _passwordValid = newValue;
    [self checkAndToggleRegisterButton];
}

- (void)setRepeatPasswordValid:(BOOL) newValue {
    _repeatPasswordValid = newValue;
    [self checkAndToggleRegisterButton];
}

- (void)checkAndToggleRegisterButton {
    self.registerButton.enabled = self.isLoginValid && self.isPasswordValid && self.isRepeatPasswordValid;
}

- (IBAction)loginTextFieldChanged:(UITextField *)sender {
    sender.layer.borderWidth = 1.0;
    sender.layer.cornerRadius = 4.0;
    
    if (self.loginTextField.text.length < 4) {
        self.loginValid = NO;
        sender.layer.borderColor = UIColor.redColor.CGColor;
    } else {
        self.loginValid = YES;
        sender.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
}

- (IBAction)passwordValueChanged:(UITextField *)sender {
    sender.layer.borderWidth = 1.0;
    sender.layer.cornerRadius = 4.0;
    
    if (sender.text.length < 6) {
        self.passwordValid = NO;
        sender.layer.borderColor = UIColor.redColor.CGColor;
    } else {
        self.passwordValid = YES;
        sender.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
}

- (IBAction)repeatPasswordValueChanged:(UITextField *)sender {
    sender.layer.borderWidth = 1.0;
    sender.layer.cornerRadius = 4.0;
    
    if (sender.text.length < 6 ||
        ![sender.text isEqualToString:self.passwordTextField.text]) {
        self.repeatPasswordValid = NO;
        sender.layer.borderColor = UIColor.redColor.CGColor;
    } else {
        self.repeatPasswordValid = YES;
        sender.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
}

- (IBAction)registerButtonTapped:(UIButton *)sender {
    self.manager.login = self.loginTextField.text;
    self.manager.primaryPassword = self.passwordTextField.text;
    [self.manager registerUserWithCompletionHandler:^(BOOL registered){
        if (registered) {
            [self.manager logInUserWithCompletionHandler:^{
                [self dismissViewControllerAnimated:YES completion:^{}];
            }];
        } else {
            NSLog(@"%@", @"There is alredy such user");
            self.loginValid = NO;
            self.loginTextField.layer.borderColor = UIColor.redColor.CGColor;
        }
    }];
}

@end
