//
//  NGNTabBarManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNTabBarManager.h"
#import "NGNCommonConstants.h"
#import "NGNTabBarController.h"
#import "NGNApplicationStateManager.h"

#import <UIKit/UIKit.h>

@interface NGNTabBarManager()

@end

@implementation NGNTabBarManager

#pragma mark - basic logic methods
+ (instancetype)sharedInstance {
    static NGNTabBarManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLoggedIn:)
                                                     name:kNGNApplicationNotificationUserLoggedIn
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLoggedOut:)
                                                     name:kNGNApplicationNotificationUserLoggedOut
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NGNTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = (NGNTabBarController *)[UIApplication sharedApplication].windows[0].rootViewController;
    }

    return _tabBarController;
}

- (void)userLoggedIn:(NSNotification *)notification {
    UITabBarItem *rootItem = self.tabBarController.tabBar.items[0];
    UITabBarItem *menuItem = self.tabBarController.tabBar.items[3];
    rootItem.enabled = YES;
    menuItem.enabled = YES;
    self.tabBarController.selectedIndex = 0;
}

- (void)userLoggedOut:(NSNotification *)notification {
    UITabBarItem *rootItem = self.tabBarController.tabBar.items[0];
    UITabBarItem *menuItem = self.tabBarController.tabBar.items[3];
    rootItem.enabled = NO;
    menuItem.enabled = NO;
    self.tabBarController.selectedIndex = 1;
}

@end
