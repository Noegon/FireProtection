//
//  AppDelegate.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "AppDelegate.h"
#import "NGNCoreDataModel.h"
#import "NGNCommonConstants.h"
#import "NGNStoryboardConstants.h"
#import "NGNDataBaseManager.h"
#import "NGNServerDataLoadManager.h"
#import "NGNApplicationStateManager.h"

#import "NGNServerLayerServices.h"
#import "NSManagedObject+NGNCRUDAppendix.h"

#import <CoreData/CoreData.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <SystemConfiguration/SystemConfiguration.h>

static BOOL initialLaunch = YES;
static NSNumber *userId = nil;

@interface AppDelegate ()

@property (nonatomic, strong) NGNServerDataLoadManager *serverDataLoadManager;
@property (nonatomic, strong) NGNApplicationStateManager *applicationStateManager;
@property (nonatomic, strong) UITabBarController *rootTabBarController;

@end

@implementation AppDelegate

- (void)startAppInOnlineMode:(BOOL)isAppOnline {
    
    //check if user saved last session to not tot login again
    NSDictionary *userSavedStatus = [self.applicationStateManager applicationParameterWithKey: kNGNModelSessionUserPasswordSavedParameter];
    NSNumber *userSaved = userSavedStatus[kNGNModelSessionUserPasswordSavedParameter];
    
    if (!userSavedStatus) {
        userSaved = @(NO);
    }
    
    if (isAppOnline) {
        if (!userSaved.boolValue) {
            [self launchAppInAnonimousMode:YES];
        } else {
            //check last launch delete data status to understand if last launch successful
            NSDictionary *lastsessionDeleteStatus =
                [self.applicationStateManager applicationParameterWithKey: kNGNModelSessionDataDeletedParameter];
            NSNumber *deleteSuccessful = lastsessionDeleteStatus[kNGNModelSessionDataDeletedParameter];
            if (!deleteSuccessful) {
                deleteSuccessful = @(NO);
            }
            
            //check last launch upload data status to understand if last launch successful
            NSDictionary *lastsessionUploadStatus =
                [self.applicationStateManager applicationParameterWithKey: kNGNModelSessionDataUploadedParameter];
            NSNumber *uploadSuccessful = lastsessionUploadStatus[kNGNModelSessionDataUploadedParameter];
            if (!uploadSuccessful) {
                uploadSuccessful = @(NO);
            }
            
            //fetching of userId of last saved user
            userId = @(-1);
            NSFetchRequest *request = NGNUser.fetchRequest;
            request.predicate = [NSPredicate predicateWithFormat:@"self.idx != 1"];
            NSError *error = nil;
            NSArray *users = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request error:&error];
            if (!error && users.count > 0) {
                userId = ((NGNUser *)users[0]).idx;
            }
            
            if (!deleteSuccessful.boolValue || !uploadSuccessful.boolValue) {
                [NGNServerDataLoadManager deleteDataFromServerWithContext:[NGNDataBaseManager managedObjectContext] userId:userId];
            }
        }
    } else {
        if (!userSaved.boolValue) {
            [self launchAppInAnonimousMode:YES];
        }
    }
}

- (void)launchAppInAnonimousMode:(BOOL)appShouldBeLaunchedInAnonimousMode {
    if (appShouldBeLaunchedInAnonimousMode) {
        self.rootTabBarController.selectedIndex = 1;
        [[[[self.rootTabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.rootTabBarController = (UITabBarController*)self.window.rootViewController;
    
    self.applicationStateManager = [NGNApplicationStateManager sharedInstance];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationCommonDataWasLoaded
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification *note) {
         NSDictionary *dataLoadStatus = [self.applicationStateManager applicationParameterWithKey: kNGNApplicationNotificationCommonDataWasLoaded];
         NSNumber *commonDataState = dataLoadStatus[kNGNModelSessionCommonDataLoadedParameter];
         if (commonDataState.boolValue) {
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
         NSDictionary *dataDeleteStatus = [self.applicationStateManager applicationParameterWithKey: kNGNApplicationNotificationDataWasDeletedFromServer];
         NSNumber *deleteDataState = dataDeleteStatus[kNGNModelSessionDataDeletedParameter];
         if (deleteDataState.boolValue) {
             [NGNServerDataLoadManager uploadDataToServerWithContext:[NGNDataBaseManager managedObjectContext] userId:userId];
         } else {
             NSLog(@"%@", @"Data wasn't deleted from server! Data won't be uploaded!");
         }
     }];

    [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationServerReachability
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:
     ^(NSNotification *note) {
         if (initialLaunch) {
             //check server status - reachable/unreachable to perform main apploading logic
             NSDictionary *serverStatus =
                 [self.applicationStateManager applicationParameterWithKey: kNGNModelSessionServerReachableParameter];
             NSNumber *serverReachable = serverStatus[kNGNModelSessionServerReachableParameter];

             if (serverReachable.boolValue) {
                 //if server is reachable download latest common data: vocabularies, etc...
                 initialLaunch = NO;
                 [NGNServerDataLoadManager loadCommonDataFromServerWithContext:[NGNDataBaseManager managedObjectContext]];
             } else {
                 [self startAppInOnlineMode:NO];
             }
             initialLaunch = NO;
         }
     }];
    
#warning delete datasource for debug
//    NSFileManager *manager = [NSFileManager defaultManager];
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FireProtection.sqlite"];
//    [manager removeItemAtURL:storeURL error:nil];
    
#warning test of local storage
    [NGNDataBaseManager setupCoreDataStackWithStorageName:kNGNApplicationAppName];
    
    NSData *userSavedData = [NSKeyedArchiver archivedDataWithRootObject:@{kNGNModelSessionUserPasswordSavedParameter: @(YES)}];
    [[NSUserDefaults standardUserDefaults] setObject:userSavedData forKey:kNGNModelSessionUserPasswordSavedParameter];
#warning test of local storage
    NSData *uploadData = [NSKeyedArchiver archivedDataWithRootObject:@{kNGNModelSessionDataUploadedParameter: @(NO)}];
    [[NSUserDefaults standardUserDefaults] setObject:uploadData forKey:kNGNModelSessionDataUploadedParameter];
    
    [NGNServerDataLoadManager pingServerWithCompletionHandler:^{}];
    
//    [NGNServerDataLoadManager loadCommonDataFromServerWithContext:[NGNDataBaseManager managedObjectContext]];
    
//    [NGNServerDataLoadManager loadDataFromServerWithContext:[NGNDataBaseManager managedObjectContext] userId:@(2)];
    
//    [NGNServerDataLoadManager deleteDataFromServerWithContext:[NGNDataBaseManager managedObjectContext] userId:@(2)];
    
//    [NGNServerDataLoadManager uploadDataToServerWithContext:[NGNDataBaseManager managedObjectContext] userId:@(2)];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [NGNDataBaseManager saveContext];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - additional helper methods

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end
