//
//  NGNDataBaseLoader.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 29.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNReachability;
@class NSManagedObjectContext;

NS_ASSUME_NONNULL_BEGIN

@interface NGNServerDataLoadManager : NSObject

@property (strong, nonatomic) NGNReachability* internetReachable;
@property (strong, nonatomic) NGNReachability* hostReachable;

+ (void)pingServerWithCompletionHandler:(void (^ _Nullable)(void))completionHandler;

/**
 Method for primary loading common necessary data from server
 */
+ (void)loadCommonDataFromServerWithContext:(NSManagedObjectContext *)context;

/**
 Method for loading current user data from server
 */
+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context userId:(NSNumber *)userId;

/**
 Method for deletion data that belongs to current user from server
 */
+ (void)deleteDataFromServerWithContext:(NSManagedObjectContext *)context userId:(NSNumber *)userId;

/**
 Method for upload data that belongs to current user to server server
 (use with deleteDataFromServerWithContext: method to renew data on server after working offline)
 */
+ (void)uploadDataToServerWithContext:(NSManagedObjectContext *)context userId:(NSNumber *)userId;

#pragma mark - networking

/*Returns YES if it is avialable connection with current server, NO in other case**/
+ (BOOL)checkServerStatusWithHostName:(NSString *)hostName;

/*Returns YES if it is avialable internet connection, NO in other case**/
+ (BOOL)checkInternetStatus;

@end

NS_ASSUME_NONNULL_END
