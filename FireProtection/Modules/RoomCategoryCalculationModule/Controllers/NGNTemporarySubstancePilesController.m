//
//  NGNTemporarySubstancePilesController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 16.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNTemporarySubstancePilesController.h"
#import "NGNLocalSubstancePile.h"
#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"
#import "NGNCoreDataModel.h"
#import "NGNLocalSubstancePileDetailController.h"
#import "NGNLocalizationConstants.h"

@interface NGNTemporarySubstancePilesController ()

@end

@implementation NGNTemporarySubstancePilesController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.substancePiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGNControllerIdentifierSubstancePileCell
                                                            forIndexPath:indexPath];
    
    NGNLocalSubstancePile *currentPile = self.substancePiles[indexPath.row];
    NGNSubstance *currentSubstance = currentPile.substance;
    cell.textLabel.text = currentSubstance.name;
    double mass = currentSubstance.density.doubleValue * currentPile.pileHeight * currentPile.pileProjectionSquare;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"m = %.2f %@, Q = %.2f %@",
                                 mass,
                                 NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKilorams, nil),
                                 currentSubstance.heatOfCombusion.doubleValue,
                                 NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMegaJoules, nil)];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction =
    [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                       title:NSLocalizedString(kNGNLocalizationKeyButtonTitleDelete, nil)
                                     handler:
     ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
         [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
     }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.substancePiles removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIViewController *dstController = segue.destinationViewController;
    if ([dstController isKindOfClass:NGNLocalSubstancePileDetailController.class]) {
        if ([segue.identifier isEqualToString:kNGNStoryboardSegueLocalPileDetail]) {
            ((NGNLocalSubstancePileDetailController *)dstController).substancePile = self.substancePiles[indexPath.row];
        } else {
            dstController.navigationItem.title = NSLocalizedString(kNGNLocalizationKeyNavigationItemTitleAddPile, nil);
            ((NGNLocalSubstancePileDetailController *)dstController).substancePile = nil;
        }
    }
}

- (IBAction)unwindToTemporaryPilesController:(UIStoryboardSegue *)segue {
    if ([segue.identifier isEqualToString:kNGNStoryboardUnwindSeguePileDetailToPilesUnwindSegue]) {
        NGNLocalSubstancePileDetailController *srcController = segue.sourceViewController;
        if (!srcController.substancePile) {
            srcController.substancePile = [[NGNLocalSubstancePile alloc] init];
            [self.substancePiles addObject:srcController.substancePile];
        }
        srcController.substancePile.pileHeight = srcController.pileHeightTextField.text.doubleValue;
        srcController.substancePile.pileProjectionSquare = srcController.pileSquareTextField.text.doubleValue;
        srcController.substancePile.substance = srcController.storedSubstance;
        [self.tableView reloadData];
    }
}

@end
