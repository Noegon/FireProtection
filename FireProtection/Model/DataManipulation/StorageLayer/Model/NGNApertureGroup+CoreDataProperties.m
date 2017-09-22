//
//  NGNApertureGroup+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNApertureGroup+CoreDataProperties.h"
#import "NGNRoom+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"

@implementation NGNApertureGroup (CoreDataProperties)

+ (NSFetchRequest<NGNApertureGroup *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNApertureGroup"];
}

@dynamic idx;
@dynamic amount;
@dynamic height;
@dynamic width;
@dynamic user;
@dynamic room;

@end

@implementation NGNApertureGroup (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"height", @"width", @"amount"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
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
