//
//  NGNApplicationStateManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNApplicationStateManager.h"
#import "NGNCommonConstants.h"

typedef NS_ENUM(NSInteger, NGNApplicationNotificationName) {
    NGNApplicationNotificationCommonDataWasLoadedStatus = 0,
    NGNApplicationNotificationDataWasLoadedStatus,
    NGNApplicationNotificationDataWasUploadedToServerStatus,
    NGNApplicationNotificationDataWasDeletedFromServerStatus,
    NGNApplicationNotificationServerReachabilityStatus
};

static const NSUInteger NGNNotificationsCount = 5;

// fine descision for enum and string values binding
static NSString *const NGNStringApplicationNotificationName[] = {
    [NGNApplicationNotificationCommonDataWasLoadedStatus] = kNGNApplicationNotificationCommonDataWasLoaded,
    [NGNApplicationNotificationDataWasLoadedStatus] = kNGNApplicationNotificationDataWasLoaded,
    [NGNApplicationNotificationDataWasUploadedToServerStatus] = kNGNApplicationNotificationDataWasUploadedToServer,
    [NGNApplicationNotificationDataWasDeletedFromServerStatus] = kNGNApplicationNotificationDataWasDeletedFromServer,
    [NGNApplicationNotificationServerReachabilityStatus] = kNGNApplicationNotificationServerReachability
};

@interface NGNApplicationStateManager()

@end

@implementation NGNApplicationStateManager

#pragma mark - basic logic methods;
+ (instancetype)sharedInstance {
    static NGNApplicationStateManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
//        //notification tells that server reachability state was changed
//        for (NSUInteger i = 0; i < NGNNotificationsCount; i++) {
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(renewApplicationParameterWithNotofication:)
//                                                         name:NGNStringApplicationNotificationName[i]
//                                                       object:nil];
//        }
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - main logic methods

- (NSDictionary *)applicationParameterWithKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)renewApplicationParameter:(NSDictionary *)parameter Name:(NSString *)name {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:parameter];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:name];
}

- (void)renewApplicationParameterWithNotofication:(NSNotification *)notification {
    [self renewApplicationParameter:notification.userInfo Name:notification.name];
}

#pragma mark - accessors

- (NSNumber *)currentSessionUserId {
    if (!_currentSessionUserId.boolValue) {
        _currentSessionUserId = @(-1);
    }
    return _currentSessionUserId;
}

- (NSNumber *)lastSessionUserId {
    NSDictionary *userId = [self applicationParameterWithKey:kNGNModelSessionUserIdParameter];
    if (!userId) {
        return @(-1);
    }
    return ((NSNumber *)userId[kNGNModelSessionUserIdParameter]);
}

- (void)setLastSessionUserId:(NSNumber *)lastSessionUserId {
    NSDictionary *authorizedParams = @{kNGNModelSessionUserIdParameter:lastSessionUserId};
    [self renewApplicationParameter:authorizedParams Name:kNGNModelSessionUserIdParameter];
}

- (BOOL)isUserAuthorized {
    NSDictionary *authorized = [self applicationParameterWithKey:kNGNModelSessionIsUserAuthorized];
    if (!authorized) {
        return NO;
    }
    return ((NSNumber *)authorized[kNGNModelSessionIsUserAuthorized]).boolValue;
}

- (void)setUserAuthorized:(BOOL)userAuthorized {
    NSDictionary *authorizedParams = @{kNGNModelSessionIsUserAuthorized: @(userAuthorized)};
    [self renewApplicationParameter:authorizedParams Name:kNGNModelSessionIsUserAuthorized];
    if (userAuthorized) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationUserLoggedIn
                                                            object:nil
                                                          userInfo:authorizedParams];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationUserLoggedOut
                                                            object:nil
                                                          userInfo:authorizedParams];
    }
}

- (BOOL)isUserSessionSaved {
    NSDictionary *sessionSaved = [self applicationParameterWithKey:kNGNModelSessionIsUserSessionSaved];
    if (!sessionSaved) {
        return NO;
    }
    return ((NSNumber *)sessionSaved[kNGNModelSessionIsUserSessionSaved]).boolValue;
}

- (void)setUserSessionSaved:(BOOL)userSessionSaved {
    NSDictionary *asessionSavedParams = @{kNGNModelSessionIsUserSessionSaved: @(userSessionSaved)};
    [self renewApplicationParameter:asessionSavedParams Name:kNGNModelSessionIsUserSessionSaved];
}

- (BOOL)isCommonDataLoaded {
    NSDictionary *dataLoaded = [self applicationParameterWithKey:kNGNModelSessionCommonDataLoadedParameter];
    if (!dataLoaded) {
        return NO;
    }
    return ((NSNumber *)dataLoaded[kNGNModelSessionCommonDataLoadedParameter]).boolValue;
}

- (void)setCommonDataLoaded:(BOOL)commonDataLoaded {
    NSDictionary *dataLoadedParams = @{kNGNModelSessionCommonDataLoadedParameter: @(commonDataLoaded)};
    [self renewApplicationParameter:dataLoadedParams Name:kNGNModelSessionCommonDataLoadedParameter];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationCommonDataWasLoaded
                                                        object:nil
                                                      userInfo:dataLoadedParams];
}

- (BOOL)isDataLoaded {
    NSDictionary *dataLoaded = [self applicationParameterWithKey:kNGNModelSessionDataLoadedParameter];
    if (!dataLoaded) {
        return NO;
    }
    return ((NSNumber *)dataLoaded[kNGNModelSessionDataLoadedParameter]).boolValue;
}

- (void)setDataLoaded:(BOOL)dataLoaded {
    NSDictionary *dataLoadedParams = @{kNGNModelSessionCommonDataLoadedParameter: @(dataLoaded)};
    [self renewApplicationParameter:dataLoadedParams Name:kNGNModelSessionDataLoadedParameter];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationDataWasLoaded
                                                        object:nil
                                                      userInfo:dataLoadedParams];
}

- (BOOL)isDataUploaded {
    NSDictionary *dataUploaded = [self applicationParameterWithKey:kNGNModelSessionDataUploadedParameter];
    if (!dataUploaded) {
        return NO;
    }
    return ((NSNumber *)dataUploaded[kNGNModelSessionDataUploadedParameter]).boolValue;
}

- (void)setDataUploaded:(BOOL)dataUploaded {
    NSDictionary *dataUploadedParams = @{kNGNModelSessionDataUploadedParameter: @(dataUploaded)};
    [self renewApplicationParameter:dataUploadedParams Name:kNGNModelSessionDataUploadedParameter];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationDataWasUploadedToServer
                                                        object:nil
                                                      userInfo:dataUploadedParams];
}

- (BOOL)isDataDeleted {
    NSDictionary *dataDeleted = [self applicationParameterWithKey:kNGNModelSessionDataDeletedParameter];
    if (!dataDeleted) {
        return NO;
    }
    return ((NSNumber *)dataDeleted[kNGNModelSessionDataDeletedParameter]).boolValue;
}

- (void)setDataDeleted:(BOOL)dataDeleted {
    NSDictionary *dataDeletedParams = @{kNGNModelSessionDataDeletedParameter: @(dataDeleted)};
    [self renewApplicationParameter:dataDeletedParams Name:kNGNModelSessionDataDeletedParameter];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationDataWasDeletedFromServer
                                                        object:nil
                                                      userInfo:dataDeletedParams];
}

- (BOOL)isServerReachable {
    NSDictionary *serverReachable = [self applicationParameterWithKey:kNGNModelSessionServerReachableParameter];
    if (!serverReachable) {
        return NO;
    }
    return ((NSNumber *)serverReachable[kNGNModelSessionServerReachableParameter]).boolValue;
}

- (void)setServerReachable:(BOOL)serverReachable {
    NSDictionary *serverReachableParams = @{kNGNModelSessionServerReachableParameter: @(serverReachable)};
    [self renewApplicationParameter:serverReachableParams Name:kNGNModelSessionServerReachableParameter];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNGNApplicationNotificationServerReachability
                                                        object:nil
                                                      userInfo:serverReachableParams];
}

@end
