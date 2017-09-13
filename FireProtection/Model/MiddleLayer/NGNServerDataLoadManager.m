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

@property (strong, nonatomic) NGNUserService *userService;
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

+ (void)servicePropertiesInitialization {
    NGNServerDataLoadManager *manager = [self sharedInstance];
    NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
    for (NSString *propertyName in propertiesDictionary.allKeys) {
        if ([propertyName containsString:@"Service"]) {
            id<NGNServiceProtocol> service = [[NSClassFromString(propertiesDictionary[propertyName]) alloc] init];
            [manager setValue:service forKey:propertyName];
        }
    }
}

+ (BOOL)isVocabularyEntityService:(id<NGNServiceProtocol>)service {
    const char *classname = class_getName(service.class);
    NSString *serviceClassName = [NSString stringWithUTF8String:classname];
    for (NSString *name in NGNCoreDataEntitiesNames.vocabularyEntities) {
        if ([serviceClassName isEqualToString:[NSString stringWithFormat:@"%@Service", name]]) {
            return YES;
        }
    }
    return NO;
}

+ (Class<NGNManagedObjectMappingProtocol>)entityClassByService:(id<NGNServiceProtocol>)service {
    const char *classname = class_getName(service.class);
    NSString *serviceClassName = [NSString stringWithUTF8String:classname];
    NSString *const servicePostfix = @"Service";
    NSString *entityClassName =
        [serviceClassName substringToIndex:(serviceClassName.length - servicePostfix.length)];
    return NSClassFromString(entityClassName);
}

+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context {
    
    [self servicePropertiesInitialization];
    
    NGNServerDataLoadManager *manager = [self sharedInstance];
    
    if ([self checkInternetStatus] && [self checkServerStatusWithHostName:kNGNServerURL]) {

        dispatch_semaphore_t mySemaphore = dispatch_semaphore_create(8);

        dispatch_queue_attr_t myAttribute =
            dispatch_queue_attr_make_with_qos_class(nil,
                                                    QOS_CLASS_USER_INITIATED,
                                                    DISPATCH_QUEUE_PRIORITY_HIGH);
        dispatch_queue_t dataLoadQueue = dispatch_queue_create("com.fireProtection.dataLoadQueue", myAttribute);

        dispatch_async(dataLoadQueue, ^{

            [manager.userService fetchEntityById:@1 completionBlock:^(NSDictionary *entity) {
                FEMMapping *userMapping = [NGNUser defaultMapping];
                NSDictionary *usersResult = [FEMDeserializer objectFromRepresentation:entity
                                                                              mapping:userMapping
                                                                              context:context];
                if (!usersResult) {
                    NSLog(@"%@", @"user wasn't loaded");
                } else {
                    NSLog(@"%@", @"user was loaded successfully");
                }

                dispatch_semaphore_signal(mySemaphore);
            }];

            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);

            //Loading vocabularies
            NSDictionary *propertiesDictionary = [NGNPropertyUtil propertiesOfObject:(NSObject *)manager];
            for (NSString *propertyName in propertiesDictionary.allKeys) {
                id<NGNServiceProtocol> service = [manager valueForKey:propertyName];
                if ([self isVocabularyEntityService:service]) {
                    [service fetchEntities:^(NSArray *entities) {
                        FEMMapping *entitiesMapping =
                            [[self entityClassByService:service] defaultMapping];
                        NSArray *result = [FEMDeserializer collectionFromRepresentation:entities
                                                                                mapping:entitiesMapping
                                                                                context:context];
                        if (!result) {
                            NSLog(@"%@ %@", [self entityClassByService:service], @"wasn't loaded");
                        } else {
                            NSLog(@"%@ %@", [self entityClassByService:service], @"was loaded successfully");
                        }
                        
                        dispatch_semaphore_signal(mySemaphore);
                    }];
                    
                }
                
                dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
                
            }
            
//            [catalogService fetchPhones:^(NSArray *phones) {
//                FEMMapping *phonesMapping = [NGNGood defaultMapping];
//                NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
//                                                                              mapping:phonesMapping
//                                                                              context:context];
//                if (!phonesResult) {
//                    NSLog(@"%@", @"goods catalog wasn't loaded");
//                } else {
//                    NSLog(@"%@", @"goods was loaded successfully");
//                }
//                dispatch_semaphore_signal(mySemaphore);
//            }];

//            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
//
//            [goodsOrderService fetchGoodsOrders:^(NSArray *goodsOrders) {
//                FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
//                NSArray *goodsOrdersResult = [FEMDeserializer collectionFromRepresentation:goodsOrders
//                                                                                   mapping:goodsOrderMapping
//                                                                                   context:context];
//                if (!goodsOrdersResult) {
//                    NSLog(@"%@", @"goodsOrders wasn't loaded");
//                } else {
//                    NSLog(@"%@", @"goodsOrders was loaded successfully");
//                }
//                dispatch_semaphore_signal(mySemaphore);
//            }];
//
//            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
//
//            [orderService fetchOrders:^(NSArray *orders) {
//                FEMMapping *orderMapping = [NGNOrder defaultMapping];
//                NSArray *ordersResult = [FEMDeserializer collectionFromRepresentation:orders
//                                                                              mapping:orderMapping
//                                                                              context:context];
//                if (!ordersResult) {
//                    NSLog(@"%@", @"ordersResult wasn't loaded");
//                } else {
//                    [self checkCartExistingInManagedObjectContext:context];
//                    NSLog(@"%@", @"orders was loaded successfully");
//                }
//                dispatch_semaphore_signal(mySemaphore);
//            }];
//
//            [NGNDataBaseRuler saveContext];
//
//
//            NSNotification *notification =
//            [NSNotification notificationWithName:NGNControllerNotificationDataWasLoaded
//                                          object:nil];
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
//            NSLog(@"%@", @"server data was loaded successfully");
        });
    }
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
