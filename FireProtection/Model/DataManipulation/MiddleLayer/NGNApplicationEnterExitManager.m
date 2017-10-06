//
//  NGNApplicationStartEndManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNApplicationEnterExitManager.h"
#import "NGNCoreDataModel.h"
#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"
#import "NGNDataBaseManager.h"
#import "NGNServerDataLoadManager.h"
#import "NGNApplicationStateManager.h"

#import "NGNTabBarManager.h"
#import "NGNTabBarController.h"

#import <UIKit/UIKit.h>


@interface NGNApplicationEnterExitManager ()

@property (assign, nonatomic, getter=isAppInStartMode) BOOL appInStartMode;
@property (strong, nonatomic) UITabBarController *rootTabBarController;

@end

@implementation NGNApplicationEnterExitManager

#pragma mark - basic logic methods
+ (instancetype)sharedInstance {
    static NGNApplicationEnterExitManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _initialLaunch = YES;
        _appInStartMode = YES;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationCommonDataWasLoaded
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             //check if common data was loaded
             if ([NGNApplicationStateManager sharedInstance].commonDataLoaded) {
                 [self startAppInOnlineMode:YES];
             } else {
                 NSLog(@"%@", @"Application cannot be loaded!");
#warning - change abort with another behavior!!!
                 abort();
             }
         }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationDataWasDeletedFromServer
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             if (self.isAppInStartMode) {
                 //check if data was deleted last time
                 if ([NGNApplicationStateManager sharedInstance].dataDeleted) {
                     [NGNServerDataLoadManager uploadDataToServerWithContext:[NGNDataBaseManager managedObjectContext]
                                                                      userId:[NGNApplicationStateManager sharedInstance].lastSessionUserId];
                 } else {
                     self.appInStartMode = NO;
                     NSLog(@"%@", @"Data wasn't deleted from server! Data won't be uploaded!");
                 }
             }
         }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationServerReachability
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             if (self.isInitialLaunch) {
                 //check server status - reachable/unreachable to perform main apploading logic
                 if ([NGNApplicationStateManager sharedInstance].serverReachable) {
                     //if server is reachable download latest common data: vocabularies, etc...
                     self.initialLaunch = NO;
                     [NGNServerDataLoadManager loadCommonDataFromServerWithContext:[NGNDataBaseManager managedObjectContext]];
                 } else {
                     [self startAppInOnlineMode:NO];
                 }
                 self.initialLaunch = NO;
             }
         }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private methods

- (void)startAppInOnlineMode:(BOOL)isAppOnline {
    
    if (isAppOnline) {
        
        //check if user saved last session to not login again
        if (![NGNApplicationStateManager sharedInstance].isUserSessionSaved &&
            ![NGNApplicationStateManager sharedInstance].isUserAuthorized) {
            [self launchAppInAnonimousMode];
        } else {
            //if session was saved, current user id would be the same as it was at last launch
            [NGNApplicationStateManager sharedInstance].currentSessionUserId =
                [NGNApplicationStateManager sharedInstance].lastSessionUserId;
        }
        //if last launch wasn't successful, we should to renew last user data before change user
        [self launchAppDataRenewProcess];
        
    } else {
        if (![NGNApplicationStateManager sharedInstance].isUserSessionSaved) {
            [self launchAppInAnonimousMode];
        }
    }
}

- (UITabBarController *)rootTabBarController {
    return (UITabBarController *)[UIApplication sharedApplication].windows[0].rootViewController;
}

- (void)launchAppInAnonimousMode {
    
//    self.rootTabBarController.selectedIndex = 1;
//    [[[self.rootTabBarController tabBar]items]objectAtIndex:0].enabled = NO;
//    [[[self.rootTabBarController tabBar]items]objectAtIndex:3].enabled = NO;
    [NGNTabBarManager sharedInstance].tabBarController.selectedIndex = 1;
    [NGNTabBarManager sharedInstance].tabBarController.tabBar.items[0].enabled = NO;
    [NGNTabBarManager sharedInstance].tabBarController.tabBar.items[3].enabled = NO;
}


- (BOOL)launchAppDataRenewProcess {
    self.appInStartMode = YES;
    if (![NGNApplicationStateManager sharedInstance].dataDeleted ||
        ![NGNApplicationStateManager sharedInstance].dataUploaded) {
        [NGNServerDataLoadManager deleteDataFromServerWithContext:[NGNDataBaseManager managedObjectContext]
                                                           userId:[NGNApplicationStateManager sharedInstance].lastSessionUserId];
        return YES;
    }
    self.appInStartMode = NO;
    return NO;
}

- (void)launchExitApplicationPreparations {
    if (![NGNApplicationStateManager sharedInstance].userSessionSaved) {
        [NGNApplicationStateManager sharedInstance].userAuthorized = NO;
    }
    //before we exit our app we should upload data on server
    [self launchAppDataRenewProcess];
    //before we exit our app we should save last loginned user id
    [NGNApplicationStateManager sharedInstance].lastSessionUserId =
        [NGNApplicationStateManager sharedInstance].currentSessionUserId;
}


@end
