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

typedef NS_ENUM(NSInteger, NGNProperties) {
    NGNSubstanceDensity = 0,
    NGNSubstanceAirAmount,
    NGNSubstanceHeatOfCombusion,
    NGNSubstanceFlameSpeed,
    NGNSubstanceBurningRate
};

typedef NS_ENUM(NSInteger, NGNPropertiesMeasureUnits) {
    NGNSubstanceDensityUnit = 0,
    NGNSubstanceAirAmountUnit,
    NGNSubstanceHeatOfCombusionUnit,
    NGNSubstanceFlameSpeedUnit,
    NGNSubstanceBurningRateUnit,
    NGNSubstanceMolecularWeightUnit
};

static NSString *const NGNStringPropertiesAdoptedNames[] = {
    [NGNSubstanceDensity] = @"Плотность",
    [NGNSubstanceAirAmount] = @"Количество воздуха",
    [NGNSubstanceHeatOfCombusion] = @"Теплота сгооания",
    [NGNSubstanceFlameSpeed] = @"Скорость распространения пламени",
    [NGNSubstanceBurningRate] = @"Скорость выгорания"
};

static NSString *const NGNStringPropertiesMeasureUnits[] = {
    [NGNSubstanceDensityUnit] = @"кг/м3",
    [NGNSubstanceAirAmountUnit] = @"кг/кг",
    [NGNSubstanceHeatOfCombusionUnit] = @"МДж",
    [NGNSubstanceFlameSpeedUnit] = @"м/с",
    [NGNSubstanceBurningRateUnit] = @"кг/м2*с",
    [NGNSubstanceMolecularWeightUnit] = @"г/моль",
};

static NSString *const NGNStringPropertiesNames[] = {
    [NGNSubstanceDensity] = @"density",
    [NGNSubstanceAirAmount] = @"requiredAirAmount",
    [NGNSubstanceHeatOfCombusion] = @"heatOfCombusion",
    [NGNSubstanceFlameSpeed] = @"flameSpeed",
    [NGNSubstanceBurningRate] = @"burningRate",
    [NGNSubstanceMolecularWeightUnit] = @"molecularWeight"
};

static NSInteger const kNGNinfoPropertiesAmount = 5;

@implementation NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstance"];
}

@dynamic idx;
@dynamic name;
@dynamic density;
@dynamic requiredAirAmount;
@dynamic heatOfCombusion;
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
        [result appendString:NGNStringPropertiesAdoptedNames[i]];
        [result appendString:colon];
        [result appendString:whitespace];
        [result appendString:[NSString stringWithFormat:@"%.2g",
                              ((NSNumber *)[self valueForKey:NGNStringPropertiesNames[i]]).doubleValue]];
        [result appendString:whitespace];
        [result appendString:NGNStringPropertiesMeasureUnits[i]];
        if (i != kNGNinfoPropertiesAmount - 1) {
            [result appendString:newLine];
        }
    }
    return result;
}

@end

@implementation NGNSubstance (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"density"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"requiredAirAmount": @"required_air_amount",
                                           @"heatOfCombusion": @"heat_of_combusion",
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
