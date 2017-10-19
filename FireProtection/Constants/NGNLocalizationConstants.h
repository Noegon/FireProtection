//
//  NGNLocalizationConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Button titles */
static NSString *const kNGNLocalizationKeyButtonTitleDelete = @"button.title.Delete";

/* Navigation item title */
static NSString *const kNGNLocalizationKeyNavigationItemTitleAddSubstance = @"navigationItem.title.AddSubstance";
static NSString *const kNGNLocalizationKeyNavigationItemTitleAddPile = @"navigationItem.title.AddPile";

/* Table section header title */
static NSString *const kNGNLocalizationKeyTableSectionHeaderTitleCommonSubstance = @"sectionHeader.title.CommonSubstances";
static NSString *const kNGNLocalizationKeyTableSectionHeaderTitleUserSubstance = @"sectionHeader.title.UserSubstances";

#pragma mark - Model

//Measure units
static NSString *const kNGNLocalizationKeyModelMeasureUnitsGrams = @"model.measureUnits.grams";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsKilorams = @"model.measureUnits.kilograms";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMegaJoules = @"model.measureUnits.megaJoules";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMeters = @"model.measureUnits.meters";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMol = @"model.measureUnits.mol";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsSeconds = @"model.measureUnits.seconds";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMinutes = @"model.measureUnits.minutes";

//Fire resistance rank calculation
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringStandard =
    @"model.calculations.fireResistanceRank.substanceStoring.standard";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringFuel =
    @"model.calculations.fireResistanceRank.substanceStoring.fuel";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringRadiatingWarmNoFire =
    @"model.calculations.fireResistanceRank.substanceStoring.radiatingWarmNoFire";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringWetProcess =
    @"model.calculations.fireResistanceRank.substanceStoring.wetProcess";

@interface NGNLocalizationConstants : NSObject

@end
