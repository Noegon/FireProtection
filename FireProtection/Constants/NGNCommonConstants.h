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

static NSString *const kNGNModelAppName = @"FireProtection";
static NSString *const kNGNModelClassPrefix = @"NGN";
static NSString *const kNGNModelDateFormat = @"dd.MM.yyyy";

//#pragma mark - controllersIds
//
//static NSString *const kNGNControllerRootController = @"rootController";
//static NSString *const kNGNControllerMenuController = @"menuController";
//static NSString *const kNGNControllerContentController = @"contentController";
//static NSString *const kNGNControllerGoodsController = @"goodsController";
//static NSString *const kNGNControllerCartCapsuleController = @"cartCapsuleController";
//static NSString *const kNGNControllerOrdersController = @"ordersController";

#pragma mark - notifications

static NSString *const kNGNControllerNotificationDataWasLoaded = @"dataWasLoadedNotification";
static NSString *const kNGNControllerNotificationServerDataWasUploadedToServer = @"dataWasUploadedToServerNotification";
static NSString *const kNGNControllerNotificationDataWasDeletedFromServer = @"dataWasDeletedFromServerNotification";
static NSString *const kNGNControllerNotificationServerUnreacable = @"serverUnreachableNotification";
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


@interface NGNCommonConstants : NSObject

@end
