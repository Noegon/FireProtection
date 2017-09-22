//
//  NGNApplicationStateManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNApplicationStateManager : NSObject

+ (instancetype)sharedInstance;

- (NSDictionary *)applicationParameterWithKey:(NSString *)key;

@end
