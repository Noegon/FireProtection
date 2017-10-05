//
//  NGNFireResistanceRankController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNFireResistanceRankController.h"
#import "NGNDataBaseManager.h"
#import "NGNCoreDataModel.h"
#import "NGNFireResistanceRankDetailController.h"

#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"

@interface NGNFireResistanceRankController ()

@property (strong, nonatomic) NSFetchedResultsController<NGNFireResistanceRank *> *fetchedResultsController;

@end

@implementation NGNFireResistanceRankController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = [[self.fetchedResultsController sections] count];
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSInteger numOfRows = [sectionInfo numberOfObjects];
    return numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGNControllerFireResistanceRankCell
                                                            forIndexPath:indexPath];
    NGNFireResistanceRank *resistanceRank = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. - %@", indexPath.row + 1, resistanceRank.number];
    return cell;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNFireResistanceRank *> *)fetchedResultsController {
    
    NSFetchRequest<NGNFireResistanceRank *> *fetchRequest = [NGNFireResistanceRank fetchRequest];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idx.integerValue" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchRequest.fetchBatchSize = 10;
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNFireResistanceRank *> *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[NGNDataBaseManager managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationController = [segue destinationViewController];
    if ([segue.identifier isEqualToString:kNGNStoryboardSegueFireResistanceRankDetail]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender)];
        NGNFireResistanceRank *resistanceRank = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ((NGNFireResistanceRankDetailController *)destinationController).fireResistanceRank = resistanceRank;
    }
}

@end
