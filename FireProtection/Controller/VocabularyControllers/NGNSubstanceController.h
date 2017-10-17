//
//  NGNSubstanceController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicVocabularyController.h"
#import "NGNSubstance+CoreDataProperties.h"

@interface NGNSubstanceController : NGNBasicVocabularyController

@property (strong, nonatomic) NSFetchedResultsController<NGNSubstance *> *fetchedResultsController;

@end
