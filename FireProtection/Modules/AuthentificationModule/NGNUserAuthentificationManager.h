//
//  NGNUserAuthentificationManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNUserAuthentificationManager;
@protocol NGNUserAuthentificationManagerDelegate <NSObject>

@optional
- (void)authentificationManager:(NGNUserAuthentificationManager *)manager
                 didChangeLogin:(NSString *)login
           loginIsCorrectResult:(BOOL)result;

- (void)authentificationManager:(NGNUserAuthentificationManager *)manager
         didChangeTypedPassword:(NSString *)typedPassword
        passwordIsCorrectResult:(BOOL)result;

- (void)authentificationManager:(NGNUserAuthentificationManager *)manager
      didChangeRepeatedPassword:(NSString *)repeatedPassword
        passwordIsCorrectResult:(BOOL)result;

- (void)logInUser;

@end

@interface NGNUserAuthentificationManager : NSObject

@property (nonatomic, weak) id<NGNUserAuthentificationManagerDelegate> delegate;

@property (strong, nonatomic) NSString *primaryPassword;
@property (strong, nonatomic) NSString *repeatedPassword;
@property (strong, nonatomic) NSString *login;

+ (instancetype)sharedInstance;

@end
