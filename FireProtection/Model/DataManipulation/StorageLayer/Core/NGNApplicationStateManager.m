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
        //notification tells that server reachability state was changed
        for (NSUInteger i = 0; i < NGNNotificationsCount; i++) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(renewApplicationParameterWithNotofication:)
                                                         name:NGNStringApplicationNotificationName[i]
                                                       object:nil];
        }
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - main logic methods

- (NSNumber *)currentSessionUserId {
    if (!_currentSessionUserId.boolValue) {
        _currentSessionUserId = @(-1);
    }
    return _currentSessionUserId;
}

- (void)renewApplicationParameter:(NSDictionary *)parameter Name:(NSString *)name {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:parameter];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:name];
}

- (void)renewApplicationParameterWithNotofication:(NSNotification *)notification {
    [self renewApplicationParameter:notification.userInfo Name:notification.name];
}

- (NSDictionary *)applicationParameterWithKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
