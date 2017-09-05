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
#import "NGNDataBaseRuler.h"
#import "NGNServerDataLoader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#warning delete datasource for debug
//    NSFileManager *manager = [NSFileManager defaultManager];
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FireProtection.sqlite"];
//    [manager removeItemAtURL:storeURL error:nil];
    
#warning test of local storage
    [NGNDataBaseRuler setupCoreDataStackWithStorageName:NGNModelAppName];
    
    NGNUser *user = [NSEntityDescription insertNewObjectForEntityForName:@"NGNUser"
                                                  inManagedObjectContext:NGNDataBaseRuler.managedObjectContext];
    user.idx = @(foo4random());
    user.name = @"Alex";
    user.password = @"chimal666";
    
    [NGNDataBaseRuler saveContext];
    
    NSError *error = nil;
    NSArray *users = [NGNDataBaseRuler.managedObjectContext executeFetchRequest:[NGNUser fetchRequest] error:&error];
    if (!error) {
        NSLog(@"%@", users);
    }
    
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
    [NGNServerDataLoader loadDataFromServerWithContext:[NGNDataBaseRuler managedObjectContext]];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [NGNDataBaseRuler saveContext];
}

#pragma mark - additional helper methods

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end
