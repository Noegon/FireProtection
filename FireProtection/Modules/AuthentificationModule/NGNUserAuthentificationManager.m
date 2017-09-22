//
//  NGNUserAuthentificationManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNUserAuthentificationManager.h"

@implementation NGNUserAuthentificationManager

#pragma mark - basic logic methods
+ (instancetype)sharedInstance {
    static NGNUserAuthentificationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
