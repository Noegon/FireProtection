//
//  NGNSubstanceType+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstanceType+CoreDataProperties.h"

@implementation NGNSubstanceType (CoreDataProperties)

+ (NSFetchRequest<NGNSubstanceType *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstanceType"];
}

@dynamic idx;
@dynamic name;
@dynamic info;
@dynamic substances;

@end
