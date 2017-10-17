//
//  NGNRegistrationViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNRegistrationViewController.h"

@interface NGNRegistrationViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *repeatPasswordTextField;

- (IBAction)passwordValueChanged:(UITextField *)sender;
- (IBAction)repeatPasswordValueChanged:(UITextField *)sender;
- (IBAction)registerButtonTapped:(UIButton *)sender;

@end

@implementation NGNRegistrationViewController

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

- (IBAction)passwordValueChanged:(UITextField *)sender {
}

- (IBAction)repeatPasswordValueChanged:(UITextField *)sender {
}

- (IBAction)registerButtonTapped:(UIButton *)sender {
}

@end