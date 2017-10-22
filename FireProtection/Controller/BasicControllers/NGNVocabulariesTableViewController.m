//
//  NGNVocabulariesTableViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNVocabulariesTableViewController.h"
#import "NGNApplicationStateManager.h"

@interface NGNVocabulariesTableViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@end

@implementation NGNVocabulariesTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
