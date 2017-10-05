//
//  NGNStoryboardConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 26.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - storyboards
static NSString *const kNGNStoryboardNameMain = @"Main";
static NSString *const kNGNStoryboardNameAuthentification = @"Authentification";

#pragma mark - segues
//Main storyboard
static NSString *const kNGNStoryboardSegueAuthentification = @"authentificationSegue";
static NSString *const kNGNStoryboardSegueFireResistanceRankDetail = @"fireResistanceRankDetailSegue";
static NSString *const kNGNStoryboardSegueFireSafetyCategoryDetail = @"fireSafetyCategoryDetailSegue";
#pragma mark - controller id's
//Main storyboard
static NSString *const kNGNStoryboardMainFireResistanceRankControllerID = @"fireResistanceRankControllerID";
static NSString *const kNGNStoryboardMainFireResistanceRankDetailControllerID = @"fireResistanceRankDetailControllerID";
static NSString *const kNGNStoryboardMainFireSafetyCategoryControllerID = @"fireSafetyCategoryControllerID";
static NSString *const kNGNStoryboardMainFireSafetyCategoryDetailControllerID = @"fireSafetyCategoryDetailControllerID";
static NSString *const kNGNStoryboardMainFireSafetySubcategoryControllerID = @"fireSafetySubcategoryControllerID";
static NSString *const kNGNStoryboardMainSubstanceTypeControllerID = @"substanceTypeControllerID";
static NSString *const kNGNStoryboardMainSubstanceControllerID = @"substanceControllerID";

//Authentification storyboard

@interface NGNStoryboardConstants : NSObject

@end
