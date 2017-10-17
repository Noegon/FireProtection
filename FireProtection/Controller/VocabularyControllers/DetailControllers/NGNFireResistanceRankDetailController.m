//
//  NGNFireResistanceRankDetailController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNFireResistanceRankDetailController.h"
#import "NGNCoreDataModel.h"

@interface NGNFireResistanceRankDetailController ()

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *bearingElementLabel;
@property (strong, nonatomic) IBOutlet UILabel *selfBearingElementLabel;
@property (strong, nonatomic) IBOutlet UILabel *outerNonBearingWallLabel;
@property (strong, nonatomic) IBOutlet UILabel *floorCeilingLabel;
@property (strong, nonatomic) IBOutlet UILabel *coveringLabel;
@property (strong, nonatomic) IBOutlet UILabel *fermBeanLabel;
@property (strong, nonatomic) IBOutlet UILabel *stairwayWallLabel;
@property (strong, nonatomic) IBOutlet UILabel *stairwayLabel;

@end

@implementation NGNFireResistanceRankDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberLabel.text = self.fireResistanceRank.number;
    self.bearingElementLabel.text = self.fireResistanceRank.bearingElementR.stringValue;
    self.selfBearingElementLabel.text = self.fireResistanceRank.selfBearingElementRE.stringValue;
    self.outerNonBearingWallLabel.text = self.fireResistanceRank.outerNonBearingWallE.stringValue;
    self.floorCeilingLabel.text = self.fireResistanceRank.floorCeilingREI.stringValue;
    self.coveringLabel.text = self.fireResistanceRank.coveringRE.stringValue;
    self.fermBeanLabel.text = self.fireResistanceRank.fermBeanR.stringValue;
    self.stairwayWallLabel.text = self.fireResistanceRank.stairWallREI.stringValue;
    self.stairwayLabel.text = self.fireResistanceRank.stairwayR.stringValue;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 9;
}

@end
