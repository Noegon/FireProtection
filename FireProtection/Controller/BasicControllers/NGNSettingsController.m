//
//  NGNSettingsController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSettingsController.h"
#import "NGNApplicationEnterExitManager.h"
#import "NGNApplicationStateManager.h"
#import "NGNDataBaseManager.h"

@interface NGNSettingsController ()

@end

@implementation NGNSettingsController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 1:
                NSLog(@"%@", @"User signed out");
                [NGNDataBaseManager saveContext];
                [[NGNApplicationEnterExitManager sharedInstance] launchExitApplicationPreparations];
                break;
            case 2:
                NSLog(@"%@", @"Application exit");
                [NGNDataBaseManager saveContext];
                [[NGNApplicationEnterExitManager sharedInstance] launchExitApplicationPreparations];
                exit(1);
                break;
            default:
                NSLog(@"%@", @"Action doesn't handle yet");
                break;
        }
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
