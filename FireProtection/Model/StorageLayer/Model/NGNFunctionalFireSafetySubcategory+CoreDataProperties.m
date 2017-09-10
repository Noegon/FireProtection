//
//  NGNFunctionalFireSafetySubcategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetySubcategory+CoreDataProperties.h"
#import "NGNFunctionalFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFunctionalFireSafetySubcategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetySubcategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFunctionalFireSafetySubcategory"];
}

@dynamic idx;
@dynamic name;
@dynamic info;
@dynamic positions;
@dynamic functionalFireCategory;

@end

@implementation NGNFunctionalFireSafetySubcategory (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"info"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    //Adding functionalFireSafetyCategory object relationship
    FEMMapping *functionalCategoryMapping =
        [[FEMMapping alloc] initWithEntityName:[NGNFunctionalFireSafetyCategory entity].name];
    functionalCategoryMapping.primaryKey = @"idx";
    [functionalCategoryMapping addAttributesFromDictionary:@{@"idx": @"functional_fire_category"}];
    
    [mapping addRelationshipMapping:functionalCategoryMapping
                        forProperty:@"functionalFireCategory"
                            keyPath:nil];
    
    return mapping;
}

@end
