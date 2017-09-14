//
//  NGNSubstancePile+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstancePile+CoreDataProperties.h"
#import "NGNRoom+CoreDataProperties.h"
#import "NGNSubstance+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"

@implementation NGNSubstancePile (CoreDataProperties)

+ (NSFetchRequest<NGNSubstancePile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstancePile"];
}

- (NSNumber *)mass {
    double result = self.projectionSquare.doubleValue * self.mediumPileHeight.doubleValue;
    return @(result);
}

@dynamic idx;
@dynamic projectionSquare;
@dynamic mediumPileHeight;
@dynamic maxPileHeight;
@dynamic user;
@dynamic room;
@dynamic substance;

@end

@implementation NGNSubstancePile (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromDictionary:@{@"idx": @"id",
                                           @"requiredAirAmount": @"required_air_amount",
                                           @"heatOfCombusion": @"heat_of_combusion",
                                           @"flameSpeed": @"flame_speed",
                                           @"burningRate": @"burning_rate"
                                           }];
    mapping.primaryKey = @"idx";
    
    //Adding substance object relationship
    FEMMapping *substanceMapping = [[FEMMapping alloc] initWithEntityName:[NGNSubstance entity].name];
    substanceMapping.primaryKey = @"idx";
    [substanceMapping addAttributesFromDictionary:@{@"idx": @"substance"}];
    
    [mapping addRelationshipMapping:substanceMapping forProperty:@"substance" keyPath:nil];
    
    //Adding room object relationship
    FEMMapping *roomMapping =
    [[FEMMapping alloc] initWithEntityName:[NGNRoom entity].name];
    roomMapping.primaryKey = @"idx";
    [roomMapping addAttributesFromDictionary:@{@"idx": @"room"}];
    
    [mapping addRelationshipMapping:roomMapping
                        forProperty:@"room" keyPath:nil];
    
    //Adding user object relationship
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"idx";
    [userMapping addAttributesFromDictionary:@{@"idx": @"user"}];
    
    [mapping addRelationshipMapping:userMapping forProperty:@"user" keyPath:nil];
    
    return mapping;
}

@end
