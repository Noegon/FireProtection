//
//  NGNAuthentificationcontrollerViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNAuthentificationcontrollerViewController.h"

@interface NGNAuthentificationcontrollerViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender;
- (IBAction)registerButtonTapped:(UIButton *)sender;
- (IBAction)approveButtonTapped:(UIButton *)sender;
- (IBAction)rememberPasswordSwitchValueChanged:(UISwitch *)sender;
- (IBAction)exitLoginButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation NGNAuthentificationcontrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

- (IBAction)registerButtonTapped:(UIButton *)sender {
}

- (IBAction)approveButtonTapped:(UIButton *)sender {
}

- (IBAction)rememberPasswordSwitchValueChanged:(UISwitch *)sender {
}

- (IBAction)exitLoginButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
