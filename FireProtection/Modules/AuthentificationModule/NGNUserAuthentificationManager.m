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
#import "NGNApplicationEnterExitManager.h"

#import "NGNServerDataLoadManager.h"
#import "NGNServerLayerServices.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNApplicationStateManager.h"
#import "NGNCommonConstants.h"
#import "NGNServerSideLayerConstants.h"

@interface NGNUserAuthentificationManager()

@property (strong, nonatomic) NSNumber *fetchedUserId;
@property (assign, nonatomic, getter=isTypedLoginCorrect) BOOL typedLoginCorrect;
@property (assign, nonatomic, getter=isTypedPasswordCorrect) BOOL typedPasswordCorrect;
@property (assign, nonatomic, getter=isRepeatedPasswordCorrect) BOOL repeatedPasswordCorrect;
@property (assign, nonatomic, getter=isAuthentificationInProgress) BOOL authentificationInProgress;

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
        _shouldSaveUserSession = NO;
        _authentificationInProgress = NO;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationDataWasDeletedFromServer
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             if (self.isAuthentificationInProgress) {
                 //check if data was deleted last time
                 if (![NGNApplicationStateManager sharedInstance].dataDeleted) {
                     self.authentificationInProgress = NO;
                     NSLog(@"%@", @"Data wasn't deleted from server! Data won't be uploaded!");
                 }
             }
         }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationDataWasUploadedToServer
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             if (self.isAuthentificationInProgress) {
                 self.authentificationInProgress = NO;
                 //check if data was deleted last time
                 if ([NGNApplicationStateManager sharedInstance].dataUploaded) {
                     [NGNApplicationStateManager sharedInstance].currentSessionUserId = self.fetchedUserId;
                     [NGNApplicationStateManager sharedInstance].userAuthorized = YES;
                     [NGNApplicationStateManager sharedInstance].userSessionSaved = self.shouldSaveUserSession;
                 } else {
                     NSLog(@"%@", @"Data wasn't uploaded to server! User could not be authorized!");
                 }
             }
         }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:kNGNApplicationNotificationDataWasLoaded
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:
         ^(NSNotification *note) {
             if (self.isAuthentificationInProgress) {
                 self.authentificationInProgress = NO;
                 //check if data was deleted last time
                 if ([NGNApplicationStateManager sharedInstance].dataLoaded) {
                     [NGNApplicationStateManager sharedInstance].currentSessionUserId = self.fetchedUserId;
                     [NGNApplicationStateManager sharedInstance].userAuthorized = YES;
                     [NGNApplicationStateManager sharedInstance].userSessionSaved = self.shouldSaveUserSession;
                 } else {
                     NSLog(@"%@", @"Data wasn't loaded from server! User could not be authorized!");
                 }
             }
         }];
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPrimaryPassword:(NSString *)primaryPassword {
    _primaryPassword = primaryPassword;
//    [self.delegate authentificationManager:self
//                    didChangeTypedPassword:self.primaryPassword
//                   passwordIsCorrectResult:self.typedPasswordCorrect];
}

- (void)setRepeatedPassword:(NSString *)repeatedPassword {
    _repeatedPassword = repeatedPassword;
//    [self.delegate authentificationManager:self
//                    didChangeTypedPassword:self.repeatedPassword
//                   passwordIsCorrectResult:self.repeatedPasswordCorrect];
}

- (void)setLogin:(NSString *)login {
    _login = login;
//    [self.delegate authentificationManager:self
//                    didChangeLogin:self.login
//                   loginIsCorrectResult:self.typedLoginCorrect];
}

- (BOOL)isTypedPasswordCorrect {
    return [NGNRegexMatchUtil isString:self.primaryPassword matchToRegex:kNGNModelEntityUserPasswordRegex];
}

- (BOOL)isTypedLoginCorrect {
    return [NGNRegexMatchUtil isString:self.login matchToRegex:kNGNModelEntityUserLoginRegex];
}

- (BOOL)isRepeatedPasswordCorrect {
    if (self.isTypedPasswordCorrect &&
        self.primaryPassword == self.repeatedPassword) {
        return YES;
    }
    return NO;
}

- (void)logInUserWithCompletionHandler:(void (^)(void))completionHandler {
    
    dispatch_group_t group = dispatch_group_create();
    
    __block __weak NGNUserAuthentificationManager *weakSelf = self;
    [NGNServerDataLoadManager pingServerWithCompletionHandler:
     ^{
         dispatch_group_enter(group);
         
         NGNUserService *userService = [NGNUserService new];
         [userService fetchEntitiesWithAdditionalParameters:@{@"name": weakSelf.login,
                                                              @"password": weakSelf.primaryPassword
                                                              }
                                            completionBlock:
          ^(NSArray *entities, NSError *error) {
              if (!error) {
                  if (entities.count != 0) {
                      NSDictionary *user = entities[0];
                      NSNumber *userId = user[kNGNResponseObjectsParametersId];
                      NSFetchRequest *request = [NGNUser fetchRequest];
                      request.predicate = [NSPredicate predicateWithFormat:@"self.idx == %@", userId];
                      NSError *error = nil;
                      NSArray *localUsers = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request error:&error];
                      if (!error && localUsers.count == 0) {
                          FEMMapping *userMapping = [NGNUser defaultMapping];
                          NSArray *usersResult = [FEMDeserializer collectionFromRepresentation:entities
                                                                                       mapping:userMapping
                                                                                       context:[NGNDataBaseManager managedObjectContext]];
                          [NGNDataBaseManager saveContext];
                          
                          if (usersResult.count == 0) {
                              NSLog(@"%@", @"user wasn't loaded. There's no such user");
                          } else {
                              NGNUser *currentUser = usersResult[0];
                              weakSelf.fetchedUserId = currentUser.idx;
                              NSLog(@"user with id: %ld was loaded successfully", weakSelf.fetchedUserId.integerValue);
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  weakSelf.authentificationInProgress = YES;
                                  [NGNServerDataLoadManager loadDataFromServerWithContext:[NGNDataBaseManager managedObjectContext]
                                                                                   userId:userId];
                                  if (completionHandler) {
                                      completionHandler();
                                  }
                              });
                          }
                      } else {
                          FEMMapping *userMapping = [NGNUser defaultMapping];
                          NSArray *usersResult = [FEMDeserializer collectionFromRepresentation:entities
                                                                                       mapping:userMapping
                                                                                       context:[NGNDataBaseManager managedObjectContext]];
                          [NGNDataBaseManager saveContext];
                          if (usersResult.count == 0) {
                              NSLog(@"%@", @"user wasn't loaded. There's no such user");
                          } else {
                              NGNUser *currentUser = usersResult[0];
                              weakSelf.fetchedUserId = currentUser.idx;
                              NSLog(@"user with id: %ld was loaded successfully", weakSelf.fetchedUserId.integerValue);
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
#warning test of data upload (previous launch error imitation)
                                  //                          [[NGNApplicationStateManager sharedInstance] setValue:@(NO) forKey:@"dataUploaded"];
                                  
                                  weakSelf.authentificationInProgress = YES;
                                  
                                  //if session was saved, current user id would be the same as it was at last launch
                                  [NGNApplicationStateManager sharedInstance].currentSessionUserId = weakSelf.fetchedUserId;
                                  
                                  //if last launch wasn't successful, we should to renew last user data before change user
                                  if (![[NGNApplicationEnterExitManager sharedInstance] launchAppDataRenewProcess]) {
                                      weakSelf.authentificationInProgress = NO;
                                      [NGNApplicationStateManager sharedInstance].userAuthorized = YES;
                                      [NGNApplicationStateManager sharedInstance].userSessionSaved = weakSelf.shouldSaveUserSession;
                                  }
                                  
                                  if (completionHandler) {
                                      completionHandler();
                                  }
                              });
                          }
                      }
                  }
              } else {
                  NSLog(@"Error occured! Error: %@", error.userInfo);
              }

              dispatch_group_leave(group);
          }];
         
         dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     }];
}

- (void)logOutUserWithCompletionHandler:(void (^)(void))completionHandler {
    
    dispatch_group_t group = dispatch_group_create();

    __block BOOL isServerReachable = NO;
    
    dispatch_group_enter(group);
    [NGNServerDataLoadManager pingServerWithCompletionHandler:
     ^{
         isServerReachable = YES;
         dispatch_group_leave(group);
     }];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    [NGNApplicationStateManager sharedInstance].userSessionSaved = NO;
    [[NGNApplicationEnterExitManager sharedInstance] launchExitApplicationPreparations];
    
    [[NGNApplicationEnterExitManager sharedInstance] startAppInOnlineMode:isServerReachable];
    
    if (completionHandler) {
        completionHandler();
    }
}

@end
