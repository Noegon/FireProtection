//
//  NGNTabBarManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNTabBarController;

@interface NGNTabBarManager : NSObject

@property (strong, nonatomic) NGNTabBarController *tabBarController;

+ (instancetype)sharedInstance;

@end
