//
//  NGNFunctionalFireSafetyCategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFunctionalFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetyCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFunctionalFireSafetyCategory"];
}

@dynamic idx;
@dynamic name;
@dynamic info;
@dynamic functionalFireSubcategories;

@end

@implementation NGNFunctionalFireSafetyCategory (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"info"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    return mapping;
}

@end

