//
//  NGNMinimumREIConstructionType+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNMinimumREIConstructionType+CoreDataProperties.h"

@implementation NGNMinimumREIConstructionType (CoreDataProperties)

+ (NSFetchRequest<NGNMinimumREIConstructionType *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNMinimumREIConstructionType"];
}

@dynamic idx;
@dynamic name;
@dynamic rooms;

@end
