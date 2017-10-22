//
//  NGNSubstance+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstance+CoreDataProperties.h"

#import "NGNSubstanceType+CoreDataClass.h"
#import "NGNUser+CoreDataProperties.h"
#import "NGNLocalizationConstants.h"

typedef NS_ENUM(NSInteger, NGNProperties) {
    NGNSubstanceDensity = 0,
    NGNSubstanceAirAmount,
    NGNSubstanceHeatOfCombusion,
    NGNSubstanceCriticalRadiationDensity,
    NGNSubstanceFlameSpeed,
    NGNSubstanceBurningRate,
    NGNSubstanceMolecularWeight,
    NGNSubstanceSplashPoint,
    NGNSubstanceSubstanceType,
    NGNSubstanceCarbonAthoms,
    NGNSubstanceHydrogenAthoms,
    NGNSubstanceOxygenAthoms,
    NGNSubstanceGaloidsAthoms,
};

static NSString *const NGNStringPropertiesNames[] = {
    [NGNSubstanceDensity] = @"density",
    [NGNSubstanceAirAmount] = @"requiredAirAmount",
    [NGNSubstanceHeatOfCombusion] = @"heatOfCombusion",
    [NGNSubstanceCriticalRadiationDensity] = @"criticalRadiationDensity",
    [NGNSubstanceFlameSpeed] = @"flameSpeed",
    [NGNSubstanceBurningRate] = @"burningRate",
    [NGNSubstanceMolecularWeight] = @"molecularWeight",
    [NGNSubstanceSplashPoint] = @"splashPoint",
    [NGNSubstanceSubstanceType] = @"substanceType",
    [NGNSubstanceCarbonAthoms] = @"carbonAthoms",
    [NGNSubstanceOxygenAthoms] = @"oxygenAthoms",
    [NGNSubstanceHydrogenAthoms] = @"hydrogenAthoms",
    [NGNSubstanceGaloidsAthoms] = @"galoidsAthoms"
};

static NSInteger const kNGNinfoPropertiesAmount = 8;

@implementation NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstance"];
}

@dynamic idx;
@dynamic name;
@dynamic density;
@dynamic requiredAirAmount;
@dynamic heatOfCombusion;
@dynamic criticalRadiationDensity;
@dynamic flameSpeed;
@dynamic burningRate;
@dynamic molecularWeight;
@dynamic splashPoint;
@dynamic carbonAthoms;
@dynamic hydrogenAthoms;
@dynamic oxygenAthoms;
@dynamic galoidsAthoms;
@dynamic user;
@dynamic substanceType;
@dynamic substancePiles;

@end

@implementation NGNSubstance (AdditionalMethods)

- (NSString *)info {
    static NSString *const newLine = @"\n";
    static NSString *const colon = @":";
    static NSString *const whitespace = @" ";
    
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:self.name];
    [result appendString:newLine];
    for (int i = 0; i < kNGNinfoPropertiesAmount; i++) {
        [result appendString:[self adoptedNameWithNGNProperties:i]];
        [result appendString:colon];
        [result appendString:whitespace];
        [result appendString:[NSString stringWithFormat:@"%.2g",
                              ((NSNumber *)[self valueForKey:NGNStringPropertiesNames[i]]).doubleValue]];
        [result appendString:whitespace];
        [result appendString:[self measureUnitsWithNGNProperties:i]];
        if (i != kNGNinfoPropertiesAmount - 1) {
            [result appendString:newLine];
        }
    }
    return result;
}
    
#pragma mark - helper methods
- (NSString *)adoptedNameWithNGNProperties:(NGNProperties)property {
    switch (property) {
        case NGNSubstanceDensity:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceDensity, nil);
        case NGNSubstanceAirAmount:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceAirAmount, nil);
        case NGNSubstanceHeatOfCombusion:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceHeatOfCombusion, nil);
        case NGNSubstanceCriticalRadiationDensity:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceCriticalRadiationDensity, nil);
        case NGNSubstanceFlameSpeed:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceFlameSpeed, nil);
        case NGNSubstanceBurningRate:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceBurningRate, nil);
        case NGNSubstanceMolecularWeight:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceMolecularWeight, nil);
        case NGNSubstanceSplashPoint:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceSplashPoint, nil);
        case NGNSubstanceSubstanceType:
            return self.substanceType.name; //FIXME: warning! Could be unlocalized!
        case NGNSubstanceCarbonAthoms:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceCarbonAthoms, nil);
        case NGNSubstanceHydrogenAthoms:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceHydrogenAthoms, nil);
        case NGNSubstanceOxygenAthoms:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceOxygenAthoms, nil);
        case NGNSubstanceGaloidsAthoms:
            return NSLocalizedString(kNGNLocalizationKeyModelSubstanceGaloidsAthoms, nil);
    }
}
    
- (NSString *)measureUnitsWithNGNProperties:(NGNProperties)property {
    switch (property) {
        case NGNSubstanceDensity:
            return [NSString stringWithFormat:@"%@/%@",
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKilorams, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMetersCubic, nil)];
        case NGNSubstanceAirAmount:
            return [NSString stringWithFormat:@"%@/%@",
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKilorams, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKilorams, nil)];
        case NGNSubstanceHeatOfCombusion:
            return NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMegaJoules, nil);
        case NGNSubstanceCriticalRadiationDensity:
            return NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKiloWatts, nil);
        case NGNSubstanceFlameSpeed:
            return [NSString stringWithFormat:@"%@/%@",
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMeters, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsSeconds, nil)];
        case NGNSubstanceBurningRate:
            return [NSString stringWithFormat:@"%@/%@*%@",
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsKilorams, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMetersSquare, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsSeconds, nil)];
        case NGNSubstanceMolecularWeight:
            return [NSString stringWithFormat:@"%@/%@",
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsGrams, nil),
                    NSLocalizedString(kNGNLocalizationKeyModelMeasureUnitsMol, nil)];
        case NGNSubstanceSplashPoint:
            return NSLocalizedString(kNGNLocalizationKeyModelMeasureCelsiumDegrees, nil);
        default:
            return @"";
    }
}

@end

@implementation NGNSubstance (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"density"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"requiredAirAmount": @"required_air_amount",
                                           @"heatOfCombusion": @"heat_of_combusion",
                                           @"criticalRadiationDensity": @"critical_radiation_density",
                                           @"flameSpeed": @"flame_speed",
                                           @"burningRate": @"burning_rate",
                                           @"molecularWeight": @"molecular_weight",
                                           @"splashPoint": @"splash_point",
                                           @"carbonAthoms": @"carbon_athoms",
                                           @"hydrogenAthoms": @"hydrogen_athoms",
                                           @"oxygenAthoms": @"oxygen_athoms",
                                           @"galoidsAthoms": @"galoids_athoms",
                                           }];
    mapping.primaryKey = @"idx";
    
    //Adding user object relationship
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"idx";
    [userMapping addAttributesFromDictionary:@{@"idx": @"user"}];
    
    [mapping addRelationshipMapping:userMapping forProperty:@"user" keyPath:nil];
    
    //Adding substanceType object relationship
    FEMMapping *substanceTypeMapping = [[FEMMapping alloc] initWithEntityName:[NGNSubstanceType entity].name];
    substanceTypeMapping.primaryKey = @"idx";
    [substanceTypeMapping addAttributesFromDictionary:@{@"idx": @"substance_type"}];
    
    [mapping addRelationshipMapping:substanceTypeMapping forProperty:@"substanceType" keyPath:nil];
    
    return mapping;
}

@end
