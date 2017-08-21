//
//  NGNSubstancePile+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstancePile+CoreDataProperties.h"

@implementation NGNSubstancePile (CoreDataProperties)

+ (NSFetchRequest<NGNSubstancePile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstancePile"];
}

@dynamic mass;
@dynamic idx;
@dynamic maxPileHeight;
@dynamic room;
@dynamic substance;

@end
