//
//  NGNPosition+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNPosition+CoreDataProperties.h"

@implementation NGNPosition (CoreDataProperties)

+ (NSFetchRequest<NGNPosition *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNPosition"];
}

@dynamic idx;
@dynamic name;
@dynamic number;
@dynamic fullSquare;
@dynamic usefulSquare;
@dynamic structuralVolume;
@dynamic info;
@dynamic project;
@dynamic rooms;
@dynamic fireResistanceRank;
@dynamic functionalFireSafetyCategory;
@dynamic fireSafetyCategory;

@end
