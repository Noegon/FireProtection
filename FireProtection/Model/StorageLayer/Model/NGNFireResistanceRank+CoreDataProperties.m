//
//  NGNFireResistanceRank+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireResistanceRank+CoreDataProperties.h"

@implementation NGNFireResistanceRank (CoreDataProperties)

+ (NSFetchRequest<NGNFireResistanceRank *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFireResistanceRank"];
}

@dynamic bearingElementR;
@dynamic coveringRE;
@dynamic fermBeanR;
@dynamic floorCeilingREI;
@dynamic idx;
@dynamic number;
@dynamic outerNonBearingWallE;
@dynamic selfBearingElementRE;
@dynamic stairWallREI;
@dynamic stairwayR;
@dynamic positions;

@end
