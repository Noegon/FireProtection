//
//  NGNSubstanceTypeController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstanceTypeController.h"
#import "NGNDataBaseManager.h"
#import "NGNCoreDataModel.h"
#import "NGNSubstanceTypeDetailController.h"

#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"

@interface NGNSubstanceTypeController ()

@property (strong, nonatomic) NSFetchedResultsController<NGNSubstanceType *> *fetchedResultsController;

@end

@implementation NGNSubstanceTypeController

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGNControllerSubstanceTypeCell
                                                            forIndexPath:indexPath];
    NGNSubstanceType *substanceType = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. - %@", indexPath.row + 1, substanceType.info];
    return cell;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNSubstanceType *> *)fetchedResultsController {
    
    NSFetchRequest<NGNSubstanceType *> *fetchRequest = [NGNSubstanceType fetchRequest];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idx.integerValue" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchRequest.fetchBatchSize = 10;
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNSubstanceType *> *aFetchedResultsController =
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
    if ([segue.identifier isEqualToString:kNGNStoryboardSegueSubstanceTypeDetail]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender)];
        NGNSubstanceType *substanceType = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ((NGNSubstanceTypeDetailController *)destinationController).substanceType = substanceType;
    }
}

@end
