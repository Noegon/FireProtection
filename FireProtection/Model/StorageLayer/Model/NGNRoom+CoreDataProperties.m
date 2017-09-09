//
//  NGNRoom+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNRoom+CoreDataProperties.h"

@implementation NGNRoom (CoreDataProperties)

+ (NSFetchRequest<NGNRoom *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNRoom"];
}

@dynamic height;
@dynamic idx;
@dynamic number;
@dynamic square;
@dynamic name;
@dynamic apertureGroups;
@dynamic fireSafetyCategory;
@dynamic minimumREIConstructionType;
@dynamic position;
@dynamic substancePiles;

@end
