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
#import "NGNCommonConstants.h"

//static NSString *const kNGNApplicationNotificationUserLoggedIn = @"userLoggedIn";
//static NSString *const kNGNApplicationNotificationUserLoggedOut = @"userLoggedOut";

@interface NGNSettingsController ()
    
@property (strong, nonatomic) id<NSObject> userDidLoggedInNotification;
@property (strong, nonatomic) id<NSObject> userDidLoggedOutNotification;

@end

@implementation NGNSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDidLoggedInNotification =
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationUserLoggedIn
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
     ^(NSNotification * _Nonnull note) {
         [self.tableView reloadData];
     }];
    
    self.userDidLoggedOutNotification =
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationUserLoggedOut
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
     ^(NSNotification * _Nonnull note) {
         [self.tableView reloadData];
     }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_userDidLoggedInNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_userDidLoggedOutNotification];
}
    
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

@end
