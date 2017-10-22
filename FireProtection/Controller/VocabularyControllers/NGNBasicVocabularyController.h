//
//  NGNBasicVocabularyController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "NGNBasicTableViewController.h"

@interface NGNBasicVocabularyController : NGNBasicTableViewController <NSFetchedResultsControllerDelegate,
                                                       UITableViewDelegate>

@property (strong, nonatomic) id<NSObject> commonDataWasLoadedNotification;
@property (strong, nonatomic) NSNumber *currentUserId;

@end
