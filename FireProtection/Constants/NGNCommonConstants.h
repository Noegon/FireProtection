//
//  NGNCommonConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
//checking system version
#define SYSTEM_VERSION_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface NGNCommonConstants : NSObject

@end
