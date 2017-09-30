//
//  NGNApplicationStateManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNApplicationStateManager : NSObject

@property (strong, nonatomic) NSNumber *currentSessionUserId;

+ (instancetype)sharedInstance;

- (NSDictionary *)applicationParameterWithKey:(NSString *)key;

@end
