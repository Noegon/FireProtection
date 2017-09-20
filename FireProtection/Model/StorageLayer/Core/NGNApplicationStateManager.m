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
    NGNApplicationNotificationDataWasLoadedStatus = 0,
    NGNApplicationNotificationDataWasUploadedToServerStatus,
    NGNApplicationNotificationDataWasDeletedFromServerStatus,
    NGNApplicationNotificationServerReachabilityStatus
};

static const NSUInteger NGNNotificationsCount = 4;

// fine descision for enum and string values binding
static NSString *const NGNStringApplicationNotificationName[] = {
    [NGNApplicationNotificationDataWasLoadedStatus] = kNGNApplicationNotificationDataWasLoadedStatus,
    [NGNApplicationNotificationDataWasUploadedToServerStatus] = kNGNApplicationNotificationDataWasUploadedToServerStatus,
    [NGNApplicationNotificationDataWasDeletedFromServerStatus] = kNGNApplicationNotificationDataWasDeletedFromServerStatus,
    [NGNApplicationNotificationServerReachabilityStatus] = kNGNApplicationNotificationServerReachabilityStatus
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

- (void)renewApplicationParameterWithNotofication:(NSNotification *)notification {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:notification.userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:notification.name];
}

- (NSDictionary *)applicationParameterWithKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
