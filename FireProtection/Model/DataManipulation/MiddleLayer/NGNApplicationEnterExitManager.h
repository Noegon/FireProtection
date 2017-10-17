//
//  NGNApplicationEnterExitManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNApplicationEnterExitManager : NSObject

@property (assign, nonatomic, getter=isInitialLaunch) BOOL initialLaunch;

+ (instancetype)sharedInstance;

- (void)startAppInOnlineMode:(BOOL)isAppOnline;

/**Method return YES if application needs to renew data and NO if last delete/upload process was successful*/
- (BOOL)launchAppDataRenewProcess;

- (void)launchExitApplicationPreparations;

@end
