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

static NSString *const NGNModelAppName = @"FireProtection";
static NSString *const NGNModelDateFormat = @"dd.MM.yyyy";

#pragma mark - controllersIds

static NSString *const NGNControllerRootController = @"rootController";
static NSString *const NGNControllerMenuController = @"menuController";
static NSString *const NGNControllerContentController = @"contentController";
static NSString *const NGNControllerGoodsController = @"goodsController";
static NSString *const NGNControllerCartCapsuleController = @"cartCapsuleController";
static NSString *const NGNControllerOrdersController = @"ordersController";

#pragma mark - notifications

static NSString *const NGNControllerNotificationDataWasLoaded = @"dataWasLoaded";
static NSString *const NGNControllerNotificationGoodsWasLoaded = @"goodsWasLoaded";
static NSString *const NGNControllerNotificationUserWasLoaded = @"userWasLoaded";
static NSString *const NGNControllerNotificationOrdersWasLoaded = @"ordersWasLoaded";
static NSString *const NGNControllerNotificationGoodsOrdersWasLoaded = @"goodsOrdersWasLoaded";

#pragma mark - table cells

static NSString *const NGNControllerOrderCell = @"OrderCell";
static NSString *const NGNControllerMenuCell = @"MenuCell";
static NSString *const NGNControllerGoodsInListCell = @"GoodsInListCell";
static NSString *const NGNControllerAvialableGoodsInCartCell = @"AvialableGoodsInCartCell";
static NSString *const NGNControllerNotAvialableGoodsInCartCell = @"NotAvialableGoodsInCartCell";

#pragma mark - fonts parameters
static NSString *const NGNControllerHelveticaLightFont = @"Helvetica-Light";
static NSInteger const NGNControllerMenuFontHeight = 30;


@interface NGNCommonConstants : NSObject

@end
