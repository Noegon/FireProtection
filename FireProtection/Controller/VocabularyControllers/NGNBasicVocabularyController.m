//
//  NGNBasicVocabularyController.m
//  ShoppingCart
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicVocabularyController.h"
#import "NGNCommonConstants.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNApplicationStateManager.h"

@interface NGNBasicVocabularyController ()

@end

@implementation NGNBasicVocabularyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commonDataWasLoadedNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationCommonDataWasLoaded
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification *notification) {
         [self.tableView reloadData];
     }];
    self.currentUserId = [NGNApplicationStateManager sharedInstance].currentSessionUserId;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_commonDataWasLoadedNotification];
}

@end
