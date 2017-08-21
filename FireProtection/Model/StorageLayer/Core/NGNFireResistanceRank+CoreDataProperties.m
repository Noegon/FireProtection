//
//  NGNFireResistanceRank+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
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
