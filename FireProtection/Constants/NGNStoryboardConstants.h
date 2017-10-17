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
static NSString *const kNGNStoryboardSegueSubstanceTypeDetail = @"substanceTypeDetailSegue";
static NSString *const kNGNStoryboardSegueSubstanceDetail = @"substanceDetailSegue";
static NSString *const kNGNStoryboardSegueAddNewSubstance = @"addNewSubstanceSegue";
static NSString *const kNGNStoryboardSegueAddNewLocalPile = @"addNewLocalPileSegue";
static NSString *const kNGNStoryboardSegueLocalPileDetail = @"localPileDetailSegue";
static NSString *const kNGNStoryboardSegueSelectSubstanceForFireHazardCalculation = @"selectSubstanceForFireHazardCalculationSegue";
static NSString *const kNGNStoryboardUnwindSeguePilesToFIreHazardCalculation = @"pilesToFIreHazardCalculationUnwindSegue";
static NSString *const kNGNStoryboardUnwindSeguePileDetailToPilesUnwindSegue = @"pileDetailToPilesUnwindSegue";

#pragma mark - controller id's
//Main storyboard
static NSString *const kNGNStoryboardMainFireResistanceRankControllerID = @"fireResistanceRankControllerID";
static NSString *const kNGNStoryboardMainFireResistanceRankDetailControllerID = @"fireResistanceRankDetailControllerID";
static NSString *const kNGNStoryboardMainFireSafetyCategoryControllerID = @"fireSafetyCategoryControllerID";
static NSString *const kNGNStoryboardMainFireSafetyCategoryDetailControllerID = @"fireSafetyCategoryDetailControllerID";
//static NSString *const kNGNStoryboardMainFireSafetySubcategoryControllerID = @"fireSafetySubcategoryControllerID";
//static NSString *const kNGNStoryboardMainFireSafetySubcategoryDetailControllerID = @"fireSafetySubcategoryDetailControllerID";
static NSString *const kNGNStoryboardMainSubstanceTypeControllerID = @"substanceTypeControllerID";
static NSString *const kNGNStoryboardMainSubstanceTypeDetailControllerID = @"substanceTypeDetailControllerID";
static NSString *const kNGNStoryboardMainSubstanceControllerID = @"substanceControllerID";
static NSString *const kNGNStoryboardMainSubstanceDetailControllerID = @"substanceDetailControllerID";
static NSString *const kNGNStoryboardMainSettingsControllerId = @"settingsControllerID";
static NSString *const kNGNStoryboardMainFireHazardCalculationControllerId = @"fireHazardCalculationControllerID";
static NSString *const kNGNStoryboardMainLocalSubstanceDetailControllerId = @"localSubstancePileDetailControllerID";

//Authentification storyboard

@interface NGNStoryboardConstants : NSObject

@end
