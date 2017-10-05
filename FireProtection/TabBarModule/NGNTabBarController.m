//
//  NGNTabBarController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNTabBarController.h"
#import "NGNApplicationStateManager.h"

@interface NGNTabBarController ()

@end

@implementation NGNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    if (![NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.selectedIndex = 1;
        self.tabBar.items[0].enabled = NO;
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

#pragma mark - SlideNavigationController Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return NO;
}

@end
