//
//  NGNSubstanceTypeDetailController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstanceTypeDetailController.h"
#import "NGNCoreDataModel.h"

@interface NGNSubstanceTypeDetailController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation NGNSubstanceTypeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.substanceType.name;
    self.infoTextView.text = self.substanceType.info;
    self.infoTextView.editable = NO;
    [self.infoTextView resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}

@end
