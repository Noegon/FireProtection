//
//  NGNBasicTableViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicTableViewController.h"

@interface NGNBasicTableViewController () <UITextFieldDelegate>

@end

@implementation NGNBasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard:)];
    [self.tableView addGestureRecognizer:tap];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)gestureRecognizer {
    [self.tableView endEditing:YES];
}

@end
