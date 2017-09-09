//
//  NGNSubstance+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstance+CoreDataProperties.h"

@implementation NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstance"];
}

@dynamic burningRate;
@dynamic density;
@dynamic flameSpeed;
@dynamic heatOfCombusion;
@dynamic idx;
@dynamic name;
@dynamic requiredAirAmount;
@dynamic substanceSets;
@dynamic substanceType;
@dynamic user;

@end
