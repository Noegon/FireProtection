//
//  NGNApplicationStateManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNApplicationStateManager : NSObject

@property (assign, nonatomic, getter=isUserAuthorized) BOOL userAuthorized;
@property (assign, nonatomic, getter=isUserSessionSaved) BOOL userSessionSaved;
@property (assign, nonatomic, getter=isCommonDataLoaded) BOOL commonDataLoaded;
@property (assign, nonatomic, getter=isDataLoaded) BOOL dataLoaded;
@property (assign, nonatomic, getter=isDataUploaded) BOOL dataUploaded;
@property (assign, nonatomic, getter=isDataDeleted) BOOL dataDeleted;
@property (assign, nonatomic, getter=isServerReachable) BOOL serverReachable;
@property (strong, nonatomic) NSNumber *currentSessionUserId;
@property (strong, nonatomic) NSNumber *lastSessionUserId;

+ (instancetype)sharedInstance;

//- (NSDictionary *)applicationParameterWithKey:(NSString *)key;

@end
