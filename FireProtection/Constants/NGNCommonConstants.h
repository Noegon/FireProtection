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

#pragma mark - notifications

static NSString *const kNGNApplicationNotificationDataWasLoaded = @"dataLoadedFromServerStatus";
static NSString *const kNGNApplicationNotificationCommonDataWasLoaded = @"commonDataLoadedFromServerStatus";
static NSString *const kNGNApplicationNotificationDataWasUploadedToServer = @"dataUploadedToServerStatus";
static NSString *const kNGNApplicationNotificationDataWasDeletedFromServer = @"dataDeletedFromServerStatus";
static NSString *const kNGNApplicationNotificationServerReachability = @"serverReachableStatus";
static NSString *const kNGNApplicationNotificationUserLoggedIn = @"userLoggedIn";
static NSString *const kNGNApplicationNotificationUserLoggedOut = @"userLoggedOut";

static NSString *const kNGNApplicationNotificationSubstanceDidSelected = @"substanceDidSelected";
static NSString *const kNGNApplicationNotificationPileDidAdded = @"pileDidAdded";

#pragma mark - table cells

//Vocabularies
static NSString *const kNGNControllerFireResistanceRankCell = @"fireResistanceRankCell";
static NSString *const kNGNControllerFireSafetyCategoryCell = @"fireSafetyCategoryCell";
static NSString *const kNGNControllerFireSafetySubcategoryCell = @"fireSafetySubcategoryCell";
static NSString *const kNGNControllerSubstanceTypeCell = @"substanceTypeCell";
static NSString *const kNGNControllerSubstanceCell = @"substanceCell";

//Non vocabularies
static NSString *const kNGNControllerIdentifierSubstancePileCell = @"substancePileCell";
static NSString *const kNGNControllerIdentifierSubstanceDetailedCell = @"substanceDetailedCell";
static NSString *const kNGNControllerIdentifierSubstanceCell = @"substanceCell";

#pragma mark - fonts parameters
static NSString *const kNGNControllerHelveticaLightFont = @"Helvetica-Light";
static NSInteger const kNGNControllerMenuFontHeight = 30;

#pragma mark - application state parameters
static NSString *const kNGNModelSessionServerReachableParameter = @"serverReachableStatus"; //YES/NO with NSNumber wrapper
static NSString *const kNGNModelSessionUserIdParameter = @"userId"; //id of user that last logged in from device - NSNumber
static NSString *const kNGNModelSessionDataLoadedParameter = @"dataLoadedFromServerStatus"; //is data loaded from server in current session - BOOL incapsulated in NSNumber
static NSString *const kNGNModelSessionCommonDataLoadedParameter = @"commonDataLoadedFromServerStatus"; //is common data loaded from server in current session - BOOL incapsulated in NSNumber
static NSString *const kNGNModelSessionDataDeletedParameter = @"dataDeletedFromServerStatus"; //is data deleted from server in current session - BOOL incapsulated in NSNumber
static NSString *const kNGNModelSessionDataUploadedParameter = @"dataUploadedToServerStatus"; //is data deleted from server in current session - BOOL incapsulated in NSNumber
static NSString *const kNGNModelSessionIsUserAuthorized = @"isUserAuthorized"; //is application in full mode
static NSString *const kNGNModelSessionIsUserSessionSaved = @"isUserSessionSaved"; //is user session saved to launch without login/password entring in future

@interface NGNCommonConstants : NSObject

@end
