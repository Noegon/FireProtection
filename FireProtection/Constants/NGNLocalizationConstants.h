//
//  NGNLocalizationConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 20.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Labels */
static NSString *const kNGNLocalizationKeyLabelTitleError = @"label.title.error";

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
static NSString *const kNGNLocalizationKeyModelMeasureUnitsWatts = @"model.measureUnits.watts";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsKiloWatts = @"model.measureUnits.kilowatts";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMegaWatts = @"model.measureUnits.megawatts";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMeters = @"model.measureUnits.meters";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMetersSquare = @"model.measureUnits.meters.square";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMetersCubic = @"model.measureUnits.meters.cubic";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMol = @"model.measureUnits.mol";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsSeconds = @"model.measureUnits.seconds";
static NSString *const kNGNLocalizationKeyModelMeasureUnitsMinutes = @"model.measureUnits.minutes";
static NSString *const kNGNLocalizationKeyModelMeasureCelsiumDegrees = @"model.measureUnits.celsiumDegrees";

//Fire resistance rank calculation
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringStandard =
    @"model.calculations.fireResistanceRank.substanceStoring.standard";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringFuel =
    @"model.calculations.fireResistanceRank.substanceStoring.fuel";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringRadiatingWarmNoFire =
    @"model.calculations.fireResistanceRank.substanceStoring.radiatingWarmNoFire";
static NSString *const kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringWetProcess =
    @"model.calculations.fireResistanceRank.substanceStoring.wetProcess";

//Core data entities
//Substances properties names
static NSString *const kNGNLocalizationKeyModelSubstanceDensity =
    @"model.coredata.substance.property.name.substanceDensity";
static NSString *const kNGNLocalizationKeyModelSubstanceAirAmount =
    @"model.coredata.substance.property.name.substanceAirAmount";
static NSString *const kNGNLocalizationKeyModelSubstanceHeatOfCombusion =
    @"model.coredata.substance.property.name.substanceHeatOfCombusion";
static NSString *const kNGNLocalizationKeyModelSubstanceCriticalRadiationDensity =
    @"model.coredata.substance.property.name.substanceCriticalRadiationDensity";
static NSString *const kNGNLocalizationKeyModelSubstanceFlameSpeed =
    @"model.coredata.substance.property.name.substanceFlameSpeed";
static NSString *const kNGNLocalizationKeyModelSubstanceBurningRate =
    @"model.coredata.substance.property.name.substanceBurningRate";
static NSString *const kNGNLocalizationKeyModelSubstanceMolecularWeight =
    @"model.coredata.substance.property.name.substanceMolecularWeight";
static NSString *const kNGNLocalizationKeyModelSubstanceSplashPoint =
    @"model.coredata.substance.property.name.substanceSplashPoint";
static NSString *const kNGNLocalizationKeyModelSubstanceCarbonAthoms =
    @"model.coredata.substance.property.name.carbonAthoms";
static NSString *const kNGNLocalizationKeyModelSubstanceHydrogenAthoms =
    @"model.coredata.substance.property.name.hydrogenAthoms";
static NSString *const kNGNLocalizationKeyModelSubstanceOxygenAthoms =
    @"model.coredata.substance.property.name.oxygenAthoms";
static NSString *const kNGNLocalizationKeyModelSubstanceGaloidsAthoms =
    @"model.coredata.substance.property.name.galoidsAthoms";

#pragma mark - UI

static NSString *const kNGNLocalizationKeyUITextAbout = @"ui.text.about";

@interface NGNLocalizationConstants : NSObject

@end
