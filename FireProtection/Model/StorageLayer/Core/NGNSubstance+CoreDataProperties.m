//
//  NGNSubstance+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstance+CoreDataProperties.h"

@implementation NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstance"];
}

@dynamic requiredAirAmount;
@dynamic heatOfCombusion;
@dynamic flameSpeed;
@dynamic idx;
@dynamic name;
@dynamic density;
@dynamic burningRate;
@dynamic user;
@dynamic substanceSets;
@dynamic substanceType;

@end
