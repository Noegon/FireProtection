//
//  NGNFireResistanceRank+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireResistanceRank+CoreDataProperties.h"

@implementation NGNFireResistanceRank (CoreDataProperties)

+ (NSFetchRequest<NGNFireResistanceRank *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFireResistanceRank"];
}

@dynamic idx;
@dynamic number;
@dynamic bearingElementR;
@dynamic selfBearingElementRE;
@dynamic outerNonBearingWallE;
@dynamic floorCeilingREI;
@dynamic coveringRE;
@dynamic fermBeanR;
@dynamic stairWallREI;
@dynamic stairwayR;
@dynamic positions;

@end

@implementation NGNFireResistanceRank (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"number"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"bearingElementR": @"bearing_element_r",
                                           @"selfBearingElementRE": @"self_bearing_element_re",
                                           @"outerNonBearingWallE": @"outer_non_bearing_wall_e",
                                           @"floorCeilingREI": @"floor_ceiling_rei",
                                           @"coveringRE": @"covering_re",
                                           @"fermBeanR": @"ferm_bean_r",
                                           @"stairWallREI": @"stair_wall_rei",
                                           @"stairwayR": @"stairway_r"
                                           }];
    mapping.primaryKey = @"idx";
    
    return mapping;
}

@end
