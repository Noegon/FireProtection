//
//  NGNSubstancePile+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstancePile+CoreDataProperties.h"

@implementation NGNSubstancePile (CoreDataProperties)

+ (NSFetchRequest<NGNSubstancePile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstancePile"];
}

@dynamic idx;
@dynamic mass;
@dynamic maxPileHeight;
@dynamic room;
@dynamic substance;

@end
