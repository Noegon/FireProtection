//
//  NGNPosition+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNPosition+CoreDataProperties.h"

#import "NGNFireResistanceRank+CoreDataProperties.h"
#import "NGNFireSafetyCategory+CoreDataProperties.h"
#import "NGNFunctionalFireSafetySubcategory+CoreDataProperties.h"
#import "NGNProject+CoreDataProperties.h"
#import "NGNRoom+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"

@implementation NGNPosition (CoreDataProperties)

+ (NSFetchRequest<NGNPosition *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNPosition"];
}

@dynamic idx;
@dynamic info;
@dynamic name;
@dynamic number;
@dynamic structuralVolume;
@dynamic usefulSquare;
@dynamic fullSquare;
@dynamic user;
@dynamic fireResistanceRank;
@dynamic functionalFireSubcategory;
@dynamic fireSafetyCategory;
@dynamic project;
@dynamic rooms;

@end

@implementation NGNPosition (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"number", @"info"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"structuralVolume": @"structural_volume",
                                           @"usefulSquare": @"useful_square",
                                           @"fullSquare": @"full_square",
                                           }];
    mapping.primaryKey = @"idx";
    
    //Adding fireResistanceRank object relationship
    FEMMapping *fireResistanceRankMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFireResistanceRank entity].name];
    fireResistanceRankMapping.primaryKey = @"idx";
    [fireResistanceRankMapping addAttributesFromDictionary:@{@"idx": @"fire_resistance_rank"}];
    
    [mapping addRelationshipMapping:fireResistanceRankMapping
                        forProperty:@"fireResistanceRank" keyPath:nil];
    
    //Adding functionalFireSafetySubcategory object relationship
    FEMMapping *functionalFireSafetySubcategoryMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFunctionalFireSafetySubcategory entity].name];
    functionalFireSafetySubcategoryMapping.primaryKey = @"idx";
    [functionalFireSafetySubcategoryMapping addAttributesFromDictionary:@{@"idx": @"functional_fire_safety_subcategory"}];
    
    [mapping addRelationshipMapping:functionalFireSafetySubcategoryMapping
                        forProperty:@"functionalFireSubcategory" keyPath:nil];
    
    //Adding fireSafetyCategory object relationship
    FEMMapping *fireSafetyCategoryMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFireSafetyCategory entity].name];
    fireSafetyCategoryMapping.primaryKey = @"idx";
    [fireSafetyCategoryMapping addAttributesFromDictionary:@{@"idx": @"fire_safety_category"}];
    
    [mapping addRelationshipMapping:fireSafetyCategoryMapping
                        forProperty:@"fireSafetyCategory" keyPath:nil];
    
    //Adding project object relationship
    FEMMapping *projectMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNProject entity].name];
    projectMapping.primaryKey = @"idx";
    [projectMapping addAttributesFromDictionary:@{@"idx": @"project"}];
    
    [mapping addRelationshipMapping:projectMapping
                        forProperty:@"project" keyPath:nil];
    
    //Adding user object relationship
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"idx";
    [userMapping addAttributesFromDictionary:@{@"idx": @"user"}];
    
    [mapping addRelationshipMapping:userMapping forProperty:@"user" keyPath:nil];
    
    return mapping;
}

@end
