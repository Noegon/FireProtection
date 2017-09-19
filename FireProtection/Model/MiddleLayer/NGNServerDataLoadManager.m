//
//  NGNDataBaseLoader.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 29.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNServerDataLoadManager.h"
#import "NGNCommonConstants.h"
#import "NGNCoreDataEntitiesNames.h"
#import "NGNDataBaseManager.h"
#import "NGNCoreDataModel.h"
#import "NGNServerLayerServices.h"
#import "NGNReachability.h"
#import "NGNPropertyUtil.h"
#import "NGNManagedObjectMappingProtocol.h"

#import <CoreData/CoreData.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface NGNServerDataLoadManager ()

//@property (strong, nonatomic) NGNUserService *userService; //TODO: should be deleted. User data should be loaded earlier
@property (strong, nonatomic) NGNProjectService *projectService;
@property (strong, nonatomic) NGNPositionService *positionService;
@property (strong, nonatomic) NGNRoomService *roomService;
@property (strong, nonatomic) NGNApertureGroupService *apertureGroupService;
@property (strong, nonatomic) NGNSubstanceService *substanceService;
@property (strong, nonatomic) NGNSubstancePileService *substancePileService;
@property (strong, nonatomic) NGNFireResistanceRankService *fireResistanceRankService;
@property (strong, nonatomic) NGNFireSafetyCategoryService *fireSafetyCategoryService;
@property (strong, nonatomic) NGNFunctionalFireSafetyCategoryService *functionalFireSafetyCategoryService;
@property (strong, nonatomic) NGNFunctionalFireSafetySubcategoryService *functionalFireSafetySubcategoryService;
@property (strong, nonatomic) NGNSubstanceTypeService *substanceTypeService;
@property (strong, nonatomic) NGNMinimumREIConstructionTypeService *minimumREIConstructionTypeService;

@end

@implementation NGNServerDataLoadManager

#pragma mark - basic logic methods;
+ (instancetype)sharedInstance {
    static NGNServerDataLoadManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)servicePropertiesInitialization {
    NGNServerDataLoadManager *manager = [NGNServerDataLoadManager sharedInstance];
    NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
    for (NSString *propertyName in propertiesDictionary.allKeys) {
        if ([propertyName containsString:@"Service"]) {
            id<NGNServiceProtocol> service = [[NSClassFromString(propertiesDictionary[propertyName]) alloc] init];
            [manager setValue:service forKey:propertyName];
        }
    }
}

- (BOOL)isVocabularyEntityService:(id<NGNServiceProtocol>)service {
    const char *classname = class_getName(service.class);
    NSString *serviceClassName = [NSString stringWithUTF8String:classname];
    for (NSString *name in NGNCoreDataEntitiesNames.vocabularyEntities) {
        if ([serviceClassName isEqualToString:[NSString stringWithFormat:@"%@Service", name]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isNonVocabularyEntityService:(id<NGNServiceProtocol>)service {
    const char *classname = class_getName(service.class);
    NSString *serviceClassName = [NSString stringWithUTF8String:classname];
    for (NSString *name in NGNCoreDataEntitiesNames.nonVocabularyEntities) {
        if ([serviceClassName isEqualToString:[NSString stringWithFormat:@"%@Service", name]]) {
            return YES;
        }
    }
    return NO;
}

- (Class<NGNManagedObjectMappingProtocol>)entityClassByService:(id<NGNServiceProtocol>)service {
    const char *classname = class_getName(service.class);
    NSString *serviceClassName = [NSString stringWithUTF8String:classname];
    NSString *const servicePostfix = @"Service";
    NSString *entityClassName =
        [serviceClassName substringToIndex:(serviceClassName.length - servicePostfix.length)];
    return NSClassFromString(entityClassName);
}

- (void)performServerCheckRequestWithCompetionHandler:(void (^)(void))comletionHandler {
    
//    NGNServerDataLoadManager *manager = self;
//
//    [manager servicePropertiesInitialization];
//
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
//                                                                              QOS_CLASS_USER_INITIATED,
//                                                                              DISPATCH_QUEUE_PRIORITY_HIGH);
//    dispatch_queue_t queue = dispatch_queue_create("com.noegon.fireProtection.dataMaintenanceQueue", attribute);
//
//    NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
//
//    NSMutableArray *serviceArray = [[NSMutableArray alloc] init];
//
//    for (NSString *propertyName in propertiesDictionary.allKeys) {
//        id<NGNServiceProtocol> service = [manager valueForKey:propertyName];
//        if ([manager isNonVocabularyEntityService:service]) {
//            [serviceArray addObject:service];
//        }
//    }
    
    if ([NGNServerDataLoadManager checkInternetStatus] &&
        [NGNServerDataLoadManager checkServerStatusWithHostName:kNGNServerURL]) {
        NSURLRequest *checkServerRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:kNGNServerURL]];
        NSURLSessionTask *checkServerReachabilityTask =
        [[NSURLSession sharedSession] dataTaskWithRequest:checkServerRequest
                                        completionHandler:
         ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
             if (!error) {
                 dispatch_async(dispatch_get_main_queue(), comletionHandler);
             } else {
                 NSNotification *notification =
                 [NSNotification notificationWithName:kNGNControllerNotificationServerUnreacable
                                               object:nil];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
                 NSLog(@"Server is unreachable!\n%@", error.userInfo);
             }
         }];
        [checkServerReachabilityTask resume];
    }
}

+ (void)deleteDataFromServerWithContext:(NSManagedObjectContext *)context {
    
    NGNServerDataLoadManager *manager = [self sharedInstance];
    
    [manager servicePropertiesInitialization];
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                                QOS_CLASS_USER_INITIATED,
                                                                                DISPATCH_QUEUE_PRIORITY_HIGH);
    dispatch_queue_t queue = dispatch_queue_create("com.noegon.fireProtection.dataMaintenanceQueue", attribute);
    
    [manager performServerCheckRequestWithCompetionHandler:
     ^{
         dispatch_async(queue, ^{
             
             NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
             
             NSMutableArray *serviceArray = [[NSMutableArray alloc] init];
             
             for (NSString *propertyName in propertiesDictionary.allKeys) {
                 id<NGNServiceProtocol> service = [manager valueForKey:propertyName];
                 if ([manager isNonVocabularyEntityService:service]) {
                     [serviceArray addObject:service];
                 }
             }
             
             for (id<NGNServiceProtocol> service in serviceArray) {
                 NSLog(@"%@ handling...", service.class);
                 
                 //Deletion of non vocabular entities belongs to current user
                 //Fetching non vocabulary entities that belongs to current user
                 dispatch_group_enter(group);
                 
                 [service fetchEntitiesWithAdditionalParameters:@{@"user": @(2).stringValue}
                                                completionBlock:
                  ^(NSArray *entities, NSError *error) {
                      if (!error) {
                          [self deleteGroupOfEntities:entities service:service];
                          NSLog(@"%@ entities were deleted", service.class);
                      } else {
                          NSLog(@"%@ entities weren't deleted", service.class);
                      }
                      dispatch_group_leave(group);
                  }];
                 
             }
             dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
             
             NSNotification *notification =
             [NSNotification notificationWithName:kNGNControllerNotificationDataWasDeletedFromServer
                                           object:nil];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             NSLog(@"%@", @"server data was deleted from server successfully");
             
         });
     }];
}

//This method is a stub because of insufficient server API
+ (void)deleteGroupOfEntities:(NSArray *)entities service:(id<NGNServiceProtocol>)service {
    
    for (NSDictionary *entity in entities) {
        [service deleteEntity:entity completionBlock:
         ^(NSDictionary *entity, NSError *error) {
            if (error) {
                NSLog(@"%@ id: \"%@\" %@", service.class, entity[@"id"], @"wasn't deleted");
            } else {
                NSLog(@"%@ id: \"%@\" %@", service.class, entity[@"id"], @"was deleted successfully");
            }
        }];
    }
}

+ (void)uploadDataToServerWithContext:(NSManagedObjectContext *)context {
    NGNServerDataLoadManager *manager = [self sharedInstance];
    
    [manager servicePropertiesInitialization];
    
    dispatch_semaphore_t mySemaphore = dispatch_semaphore_create(1);
    
    dispatch_queue_attr_t myAttribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                                QOS_CLASS_USER_INITIATED,
                                                                                DISPATCH_QUEUE_PRIORITY_HIGH);
    dispatch_queue_t dataUploadQueue = dispatch_queue_create("com.noegon.fireProtection.dataUploadQueue", myAttribute);
    
    [manager performServerCheckRequestWithCompetionHandler:
     ^{
         dispatch_async(dataUploadQueue, ^{
             NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
             
             for (NSString *propertyName in propertiesDictionary.allKeys) {
                 id<NGNServiceProtocol> service = [manager valueForKey:propertyName];
                 
                 //Uploading non vocabular entities
                 if ([manager isNonVocabularyEntityService:service]) {
                     
                     NSFetchRequest *fetchRequest = [[manager entityClassByService:service] performSelector:@selector(fetchRequest)];
                     
                     NSError *error = nil;
                     NSArray *managedObjectsArray = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:fetchRequest error:&error];
                     
                     if (!error) {
                         
                         FEMMapping *objectMapping = [[manager entityClassByService:service] performSelector:@selector(defaultMapping)];
                         
                         for (NSManagedObject *object in managedObjectsArray) {
                             __weak id<NGNServiceProtocol> weakService = service;
                             
                             NSDictionary *entityAsDictionary = [FEMSerializer serializeObject:object usingMapping:objectMapping];
                             [service addEntity:entityAsDictionary completionBlock:^(NSDictionary *order, NSError *error) {
                                 if (error) {
                                     NSLog(@"%@ name: \"%@\" %@", weakService.class, entityAsDictionary[@"name"], @"wasn't uploaded");
                                 } else {
                                     NSLog(@"%@ name: \"%@\" %@", weakService.class, entityAsDictionary[@"name"], @"was uploaded successfully");
                                 }
                                 dispatch_semaphore_signal(mySemaphore);
                             }];
                             dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
                         }
                     }
                 }
             }
             
             NSNotification *notification =
                 [NSNotification notificationWithName:kNGNControllerNotificationServerDataWasUploadedToServer
                                               object:nil];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             NSLog(@"%@", @"server data was uploaded to server successfully");
         });
     }];
}

+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context {
    NGNServerDataLoadManager *manager = [self sharedInstance];
    
    [manager servicePropertiesInitialization];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                                QOS_CLASS_USER_INITIATED,
                                                                                DISPATCH_QUEUE_PRIORITY_HIGH);
    dispatch_queue_t queue = dispatch_queue_create("com.noegon.fireProtection.dataLoadQueue", attribute);
    
    [manager performServerCheckRequestWithCompetionHandler:
     ^{
         dispatch_async(queue, ^{
             NGNUserService *userService = [NGNUserService new];
             [userService fetchEntityById:@1 completionBlock:^(NSDictionary *entity, NSError *error) {
                 FEMMapping *userMapping = [NGNUser defaultMapping];
                 NSDictionary *usersResult = [FEMDeserializer objectFromRepresentation:entity
                                                                               mapping:userMapping
                                                                               context:context];
                 if (!usersResult) {
                     NSLog(@"%@", @"admin user wasn't loaded");
                 } else {
                     NSLog(@"%@", @"admin user was loaded successfully");
                 }
                 
                 dispatch_semaphore_signal(semaphore);
             }];
             
             dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
             
             NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
             
             for (NSString *propertyName in propertiesDictionary.allKeys) {
                 id<NGNServiceProtocol> service = [manager valueForKey:propertyName];
                 
                 //Loading vocabularies
                 if ([manager isVocabularyEntityService:service]) {
                     [service fetchEntities:
                      ^(NSArray *entities, NSError *error) {
                          NSArray *result = nil;
                          if (!error) {
                              FEMMapping *entitiesMapping = [[manager entityClassByService:service] defaultMapping];
                              result = [FEMDeserializer collectionFromRepresentation:entities
                                                                             mapping:entitiesMapping
                                                                             context:context];
                          }
                          if (!result) {
                              NSLog(@"%@ %@", [manager entityClassByService:service], @"wasn't loaded");
                          } else {
                              NSLog(@"%@ %@", [manager entityClassByService:service], @"was loaded successfully");
                          }
                          
                          dispatch_semaphore_signal(semaphore);
                      }];
                     
                     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                 }
                 
                 //Loading non vocabular entities
                 if ([manager isNonVocabularyEntityService:service]) {
                     [service fetchEntitiesWithAdditionalParameters:@{@"user": @(2).stringValue}
                                                    completionBlock:
                      ^(NSArray *entities, NSError *error) {
                          FEMMapping *entitiesMapping = [[manager entityClassByService:service] defaultMapping];
                          NSArray *result = [FEMDeserializer collectionFromRepresentation:entities
                                                                                  mapping:entitiesMapping
                                                                                  context:context];
                          
                          if (!result) {
                              NSLog(@"%@ %@", [manager entityClassByService:service], @"wasn't loaded");
                          } else {
                              NSLog(@"%@ %@", [manager entityClassByService:service], @"was loaded successfully");
                          }
                          
                          dispatch_semaphore_signal(semaphore);
                      }];
                     
                     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                 }
                 
             }
             
             //Loading common substances that belong to admin user
             [manager.substanceService fetchEntitiesWithAdditionalParameters:@{@"user": @(1).stringValue}
                                                             completionBlock:
              ^(NSArray *entities, NSError *error) {
                  FEMMapping *entitiesMapping = [NGNSubstance defaultMapping];
                  NSArray *result = [FEMDeserializer collectionFromRepresentation:entities
                                                                          mapping:entitiesMapping
                                                                          context:context];
                  if (!result) {
                      NSLog(@"Common substances wasn't loaded");
                  } else {
                      NSLog(@"Common substances was loaded successfully");
                  }
                  
                  dispatch_semaphore_signal(semaphore);
              }];
             
             dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [NGNDataBaseManager saveContext];
                 dispatch_semaphore_signal(semaphore);
                 dispatch_semaphore_signal(semaphore);
             });
             
             NSNotification *notification =
                 [NSNotification notificationWithName:kNGNControllerNotificationDataWasLoaded
                                               object:nil];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             NSLog(@"%@", @"server data was loaded successfully");
         });

     }];
}

+ (BOOL)checkServerStatusWithHostName:(NSString *)hostName {
    NGNReachability* hostReachable = [NGNReachability reachabilityWithHostName:hostName];
    // called after network status changes
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable: {
            NSLog(@"A gateway to the host server is down.");
            return NO;
        }
        case ReachableViaWiFi: {
            NSLog(@"A gateway to the host server is working via WIFI.");
            return YES;
        }
        case ReachableViaWWAN: {
            NSLog(@"A gateway to the host server is working via WWAN.");
            return YES;
        }
    }
}

+ (BOOL)checkInternetStatus {
    NGNReachability* internetReachable = [NGNReachability reachabilityForInternetConnection];
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable: {
            NSLog(@"The internet is down.");
            return NO;
        }
        case ReachableViaWiFi: {
            NSLog(@"The internet is working via WIFI.");
            return YES;
        }
        case ReachableViaWWAN: {
            NSLog(@"The internet is working via WWAN.");
            return YES;
        }
    }
}

@end
