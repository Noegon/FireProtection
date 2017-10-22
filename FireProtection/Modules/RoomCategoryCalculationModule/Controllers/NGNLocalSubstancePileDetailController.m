//
//  NGNLocalSubstancePileDetailController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 17.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNStoryboardConstants.h"
#import "NGNLocalizationConstants.h"
#import "NGNCommonConstants.h"
#import "NGNLocalSubstancePileDetailController.h"
#import "NGNCoreDataModel.h"
#import "NGNApplicationStateManager.h"
#import "NGNDataBaseManager.h"
#import "NGNSubstanceController.h"
#import "NGNLocalSubstancePile.h"

@interface NGNLocalSubstancePileDetailController ()

@property (strong, nonatomic) IBOutlet UILabel *substanceNameTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *heatOfCombusionTextLabel;

@property (strong, nonatomic) id<NSObject> substanseDidChangeNotification;

@end

@implementation NGNLocalSubstancePileDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pileAdded = NO;
    
    if (!self.substancePile) {
        //Default value of substance is wood with idx = 1
        NSFetchRequest<NGNSubstance *> *fetchRequest = [NGNSubstance fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"idx = 1"];
        NSError *error = nil;
        NSArray *substances = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        if (!error && substances.count != 0) {
            self.storedSubstance = substances[0];
        } else {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    } else {
        self.storedSubstance = self.substancePile.substance;
    }
    
    self.substanseDidChangeNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationSubstanceDidSelected
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification * _Nonnull note) {
         self.storedSubstance = (NGNSubstance *)note.userInfo[@"substance"];
     }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_substanseDidChangeNotification];
}

#pragma mark - basic methods

- (void)setStoredSubstance:(NGNSubstance *)storedSubstance {
    self.substanceNameTextLabel.text = storedSubstance.name;
    self.heatOfCombusionTextLabel.text = [NSString stringWithFormat:@"Q = %.2g %@",
                                          storedSubstance.heatOfCombusion.doubleValue,
                                          NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMegaJoules, nil)];
    _storedSubstance = storedSubstance;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kNGNStoryboardSegueSelectSubstanceForFireHazardCalculation]) {
        NGNSubstanceController *dstController = segue.destinationViewController;
        
        NSFetchRequest<NGNSubstance *> *fetchRequest = [NGNSubstance fetchRequest];
        
        if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
            
            fetchRequest.predicate = [NSPredicate predicateWithFormat:
                                      @"(user.idx = %@ OR user.idx = %@) AND (substanceType.idx != 1) AND (substanceType.idx != 2) AND (substanceType.idx != 3)",
                                      @(1),
                                      [NGNApplicationStateManager sharedInstance].currentSessionUserId];
        } else {
            fetchRequest.predicate = [NSPredicate predicateWithFormat:
                                      @"(user.idx = %@) AND (substanceType.idx != 1) AND (substanceType.idx != 2) AND (substanceType.idx != 3)", @(1)];
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
        dstController.fetchedResultsController = aFetchedResultsController;
    }
}

@end
