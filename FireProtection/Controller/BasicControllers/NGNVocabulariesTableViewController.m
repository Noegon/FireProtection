//
//  NGNVocabulariesTableViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNVocabulariesTableViewController.h"
#import "NGNApplicationStateManager.h"
#import "NGNCommonConstants.h"

@interface NGNVocabulariesTableViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@property (strong, nonatomic) id<NSObject> userDidLoggedInNotification;
@property (strong, nonatomic) id<NSObject> userDidLoggedOutNotification;

@end

@implementation NGNVocabulariesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDidLoggedInNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationUserLoggedIn
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification * _Nonnull note) {
         [self.tableView reloadData];
         self.navigationItem.rightBarButtonItem = nil;
     }];
    
    self.userDidLoggedOutNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationUserLoggedOut
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification * _Nonnull note) {
         [self.tableView reloadData];
         self.navigationItem.rightBarButtonItem = self.loginButton;
     }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_userDidLoggedInNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_userDidLoggedOutNotification];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
