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
#import "NGNServerLayerServices.h"
#import "NSManagedObject+NGNCRUDAppendix.h"

#import "NGNCommonConstants.h"
#import "NGNLocalizationConstants.h"
#import "NGNStoryboardConstants.h"

@interface NGNSubstanceController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation NGNSubstanceController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.addButton.enabled = NO;
    }
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(kNGNLocalizationKeyTableSectionHeaderTitleCommonSubstance, nil);
    }
    return NSLocalizedString(kNGNLocalizationKeyTableSectionHeaderTitleUserSubstance, nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGNControllerSubstanceCell
                                                            forIndexPath:indexPath];
    NGNSubstance *substance = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", indexPath.row + 1, [substance name]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction =
        [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                           title:NSLocalizedString(kNGNLocalizationKeyButtonTitleDelete, nil)
                                         handler:
     ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
         
         NGNSubstance *substance = [self.fetchedResultsController objectAtIndexPath:indexPath];
         if (substance.user.idx.integerValue ==
             [NGNApplicationStateManager sharedInstance].currentSessionUserId.integerValue) {
             
             [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
         } else {
             NSLog(@"%@", @"User haven't enough rights to delete this item");
         }
     }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NGNSubstance *substance = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [NGNSubstance ngn_deleteEntityInManagedObjectContext:[NGNDataBaseManager managedObjectContext]
                                               managedObject:substance];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *userInfo = @{@"substance": [self.fetchedResultsController objectAtIndexPath:indexPath]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationSubstanceDidSelected
                                                        object:nil
                                                      userInfo:userInfo];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNSubstance *> *)fetchedResultsController {
    
    if (!_fetchedResultsController) {
        NSFetchRequest<NGNSubstance *> *fetchRequest = [NGNSubstance fetchRequest];
        
        if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
            
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"user.idx = %@ OR user.idx = %@",
                                      @(1),
                                      [NGNApplicationStateManager sharedInstance].currentSessionUserId];
        } else {
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"user.idx = %@", @(1)];
        }
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idx.integerValue" ascending:YES];
        
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        fetchRequest.fetchBatchSize = 10;
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController<NGNSubstance *> *aFetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                            managedObjectContext:[NGNDataBaseManager managedObjectContext]
                                              sectionNameKeyPath:@"user.idx"
                                                       cacheName:nil];
        
        NSError *error = nil;
        if (![aFetchedResultsController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        
        _fetchedResultsController = aFetchedResultsController;
    }
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Fetched results controller delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            [self.tableView reloadData];
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
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
        ((NGNSubstanceDetailController *)destinationController).navigationItem.title =
            NSLocalizedString(kNGNLocalizationKeyNavigationItemTitleAddSubstance, nil);
    }
}

@end
