//
//  NGNAboutViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNAboutViewController.h"
#import "NGNApplicationStateManager.h"

@interface NGNAboutViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@end

@implementation NGNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.loginButton;
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
