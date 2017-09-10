//
//  NGNRoom+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNRoom+CoreDataProperties.h"

#import "NGNApertureGroup+CoreDataProperties.h"
#import "NGNFireSafetyCategory+CoreDataProperties.h"
#import "NGNMinimumREIConstructionType+CoreDataProperties.h"
#import "NGNSubstancePile+CoreDataProperties.h"
#import "NGNPosition+CoreDataProperties.h"

@implementation NGNRoom (CoreDataProperties)

+ (NSFetchRequest<NGNRoom *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNRoom"];
}

@dynamic idx;
@dynamic name;
@dynamic number;
@dynamic height;
@dynamic square;
@dynamic fireSafetyCategory;
@dynamic minimumREIConstructionType;
@dynamic position;
@dynamic substancePiles;
@dynamic apertureGroups;

@end

@implementation NGNRoom (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"number", @"height", @"square"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    //Adding fireSafetyCategory object relationship
    FEMMapping *fireSafetyCategoryMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFireSafetyCategory entity].name];
    fireSafetyCategoryMapping.primaryKey = @"idx";
    [fireSafetyCategoryMapping addAttributesFromDictionary:@{@"idx": @"fire_safety_category"}];
    
    [mapping addRelationshipMapping:fireSafetyCategoryMapping
                        forProperty:@"fireSafetyCategory" keyPath:nil];
    
    //Adding minimumREIConstructionType object relationship
    FEMMapping *minimumREIConstructionTypeMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFireSafetyCategory entity].name];
    minimumREIConstructionTypeMapping.primaryKey = @"idx";
    [minimumREIConstructionTypeMapping addAttributesFromDictionary:@{@"idx": @"minimum_rei_construction_type"}];
    
    [mapping addRelationshipMapping:minimumREIConstructionTypeMapping
                        forProperty:@"minimumREIConstructionType" keyPath:nil];
    
    //Adding position object relationship
    FEMMapping *positionMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFireSafetyCategory entity].name];
    positionMapping.primaryKey = @"idx";
    [positionMapping addAttributesFromDictionary:@{@"idx": @"position"}];
    
    [mapping addRelationshipMapping:minimumREIConstructionTypeMapping
                        forProperty:@"position" keyPath:nil];
    
    return mapping;
}

@end
