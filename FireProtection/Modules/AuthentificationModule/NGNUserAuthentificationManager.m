//
//  NGNUserAuthentificationManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNUserAuthentificationManager.h"
#import "NGNRegexMatchUtil.h"
#import "NGNCoreDataEntitiesConstants.h"

#import "NGNServerDataLoadManager.h"
#import "NGNServerLayerServices.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNApplicationStateManager.h"

@interface NGNUserAuthentificationManager()

@property (strong, nonatomic) NSNumber *fetchedUserId;
@property (assign, nonatomic, getter=isTypedLoginCorrect) BOOL typedLoginCorrect;
@property (assign, nonatomic, getter=isTypedPasswordCorrect) BOOL typedPasswordCorrect;
@property (assign, nonatomic, getter=isRepeatedPasswordCorrect) BOOL repeatedPasswordCorrect;

@end

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

- (instancetype)init {
    if (self = [super init]) {
        _login = @"";
        _primaryPassword = @"";
        _repeatedPassword = @"";
        _fetchedUserId = @(-1);
    }
    return self;
}

- (void)setPrimaryPassword:(NSString *)primaryPassword {
    _primaryPassword = primaryPassword;
    [self.delegate authentificationManager:self
                    didChangeTypedPassword:self.primaryPassword
                   passwordIsCorrectResult:self.typedPasswordCorrect];
}

- (void)setRepeatedPassword:(NSString *)repeatedPassword {
    _repeatedPassword = repeatedPassword;
    [self.delegate authentificationManager:self
                    didChangeTypedPassword:self.repeatedPassword
                   passwordIsCorrectResult:self.repeatedPasswordCorrect];
}

- (void)setLogin:(NSString *)login {
    _login = login;
    [self.delegate authentificationManager:self
                    didChangeLogin:self.login
                   loginIsCorrectResult:self.typedLoginCorrect];
}

- (BOOL)isTypedPasswordCorrect {
    return [NGNRegexMatchUtil isString:self.primaryPassword matchToRegex:kNGNModelEntityUserPasswordRegex];
}

- (BOOL)isTypedLoginCorrect {
    return [NGNRegexMatchUtil isString:self.login matchToRegex:kNGNModelEntityUserLoginRegex];
}

- (BOOL)isRepeatedPasswordCorrect {
    if (self.typedPasswordCorrect &&
        self.primaryPassword == self.repeatedPassword) {
        return YES;
    }
    return NO;
}

- (void)logInUser {
    
    dispatch_group_t group = dispatch_group_create();
    [NGNServerDataLoadManager pingServerWithCompletionHandler:
     ^{
         dispatch_group_enter(group);
         
         NGNUserService *userService = [NGNUserService new];
         [userService fetchEntitiesWithAdditionalParameters:@{@"name": self.login,
                                                              @"password": self.primaryPassword
                                                              }
                                            completionBlock:
          ^(NSArray *entities, NSError *error) {
              FEMMapping *userMapping = [NGNUser defaultMapping];
              NSArray *usersResult = [FEMDeserializer collectionFromRepresentation:entities
                                                                           mapping:userMapping
                                                                           context:[NGNDataBaseManager managedObjectContext]];
              if (usersResult.count == 0) {
                  NSLog(@"%@", @"user wasn't loaded");
              } else {
                  NSDictionary *currentUser = usersResult[0];
                  self.fetchedUserId = currentUser[kNGNResponseObjectsParametersId];
                  NSLog(@"user with id: %ld was loaded successfully", self.fetchedUserId.integerValue);
              }
              
              dispatch_group_leave(group);
          }];
         
         dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     }];
}

@end
