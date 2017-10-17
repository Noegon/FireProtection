//
//  NGNFireSafetyCategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFireSafetyCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFireSafetyCategory"];
}

@dynamic idx;
@dynamic name;
@dynamic minimumSpecificFireLoad;
@dynamic maximumSpecificFireLoad;
@dynamic info;
@dynamic rooms;
@dynamic positions;

@end

@implementation NGNFireSafetyCategory (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"info"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"minimumSpecificFireLoad": @"minimum_specific_fire_load",
                                           @"maximumSpecificFireLoad": @"maximum_specific_fore_load"
                                           }];
    mapping.primaryKey = @"idx";
    
    return mapping;
}

@end
