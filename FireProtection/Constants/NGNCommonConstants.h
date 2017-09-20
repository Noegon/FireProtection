//
//  NGNCommonConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
//checking system version
#define SYSTEM_VERSION_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

static NSString *const kNGNApplicationAppName = @"FireProtection";
static NSString *const kNGNApplicationClassPrefix = @"NGN";
static NSString *const kNGNApplicationDateFormat = @"dd.MM.yyyy";

#pragma mark - controllersIds

//static NSString *const kNGNControllerRootController = @"rootController";
//static NSString *const kNGNControllerMenuController = @"menuController";
//static NSString *const kNGNControllerContentController = @"contentController";
//static NSString *const kNGNControllerGoodsController = @"goodsController";
//static NSString *const kNGNControllerCartCapsuleController = @"cartCapsuleController";
//static NSString *const kNGNControllerOrdersController = @"ordersController";

#pragma mark - notifications

static NSString *const kNGNApplicationNotificationDataWasLoadedStatus = @"dataLoadedFromServerStatus";
static NSString *const kNGNApplicationNotificationDataWasUploadedToServerStatus = @"dataUploadedToServerStatus";
static NSString *const kNGNApplicationNotificationDataWasDeletedFromServerStatus = @"dataDeletedFromServerStatus";
static NSString *const kNGNApplicationNotificationServerReachabilityStatus = @"serverReachable";
//static NSString *const kNGNControllerNotificationGoodsWasLoaded = @"goodsWasLoaded";
//static NSString *const kNGNControllerNotificationUserWasLoaded = @"userWasLoaded";
//static NSString *const kNGNControllerNotificationOrdersWasLoaded = @"ordersWasLoaded";
//static NSString *const kNGNControllerNotificationGoodsOrdersWasLoaded = @"goodsOrdersWasLoaded";
//
//#pragma mark - table cells
//
//static NSString *const kNGNControllerOrderCell = @"OrderCell";
//static NSString *const kNGNControllerMenuCell = @"MenuCell";
//static NSString *const kNGNControllerGoodsInListCell = @"GoodsInListCell";
//static NSString *const kNGNControllerAvialableGoodsInCartCell = @"AvialableGoodsInCartCell";
//static NSString *const kNGNControllerNotAvialableGoodsInCartCell = @"NotAvialableGoodsInCartCell";

#pragma mark - fonts parameters
static NSString *const kNGNControllerHelveticaLightFont = @"Helvetica-Light";
static NSInteger const kNGNControllerMenuFontHeight = 30;

#pragma mark - application state parameters
static NSString *const kNGNModelSessionServerReachableParameter = @"sessionServerReachable"; //YES/NO with NSNumber wrapper
static NSString *const kNGNModelSessionUserIdParameter = @"sessionUserId"; //id of user that last logged in from device
static NSString *const kNGNModelSessionDataLoadedParameter = @"sessionDataLoaded"; //is data loaded from server in current session
static NSString *const kNGNModelSessionDataDeletedParameter = @"sessionDataDeleted"; //is data deleted from server in current session
static NSString *const kNGNModelSessionDataUploadedParameter = @"sessionDataUploaded"; //is data deleted from server in current session
static NSString *const kNGNModelSessionUserPasswordSavedParameter = @"sessionUserPasswordSaved"; //was user password saved to skip authorization

@interface NGNCommonConstants : NSObject

@end
