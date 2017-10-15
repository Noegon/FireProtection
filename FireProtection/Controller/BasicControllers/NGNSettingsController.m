//
//  NGNSettingsController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSettingsController.h"
#import "NGNApplicationEnterExitManager.h"
#import "NGNDataBaseManager.h"

@interface NGNSettingsController ()

@end

@implementation NGNSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"%@", @"User signed out");
                [NGNDataBaseManager saveContext];
                [[NGNApplicationEnterExitManager sharedInstance] launchExitApplicationPreparations];
                break;
            case 1:
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
