//
//  NGNPosition+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNPosition+CoreDataProperties.h"

@implementation NGNPosition (CoreDataProperties)

+ (NSFetchRequest<NGNPosition *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNPosition"];
}

@dynamic fullSquare;
@dynamic idx;
@dynamic info;
@dynamic name;
@dynamic number;
@dynamic structuralVolume;
@dynamic usefulSquare;
@dynamic fireResistanceRank;
@dynamic fireSafetyCategory;
@dynamic functionalFireSafetyCategory;
@dynamic project;
@dynamic rooms;

@end
