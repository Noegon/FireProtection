//
//  NGNSubstanceController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstanceController.h"
#import "NGNDataBaseManager.h"
#import "NGNCoreDataModel.h"
#import "NGNApplicationStateManager.h"
#import "NGNSubstanceDetailController.h"

#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"

@interface NGNSubstanceController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (strong, nonatomic) NSFetchedResultsController<NGNSubstance *> *fetchedResultsController;

@end

@implementation NGNSubstanceController

- (void)viewWillAppear:(BOOL)animated {
    if (![NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.addButton.enabled = NO;
    }
    [self.tableView reloadData];
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGNControllerSubstanceCell
                                                            forIndexPath:indexPath];
    NGNSubstance *substance = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", indexPath.row + 1, [substance name]];
    return cell;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNSubstance *> *)fetchedResultsController {
    
    NSFetchRequest<NGNSubstance *> *fetchRequest = [NGNSubstance fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"user.idx = %@ OR user.idx = %@",
                              @(1),
                              [NGNApplicationStateManager sharedInstance].currentSessionUserId];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idx.integerValue" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchRequest.fetchBatchSize = 10;
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNSubstance *> *aFetchedResultsController =
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
    if ([segue.identifier isEqualToString:kNGNStoryboardSegueSubstanceDetail]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender)];
        NGNSubstance *substance = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ((NGNSubstanceDetailController *)destinationController).substance = substance;
    }
    if ([segue.identifier isEqualToString:kNGNStoryboardSegueAddNewSubstance]) {
        ((NGNSubstanceDetailController *)destinationController).substance = nil;
        ((NGNSubstanceDetailController *)destinationController).navigationItem.title = @"Add substance";
    }
}

@end
