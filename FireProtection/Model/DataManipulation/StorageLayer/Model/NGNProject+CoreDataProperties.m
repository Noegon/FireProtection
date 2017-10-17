//
//  NGNProject+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNProject+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"

@implementation NGNProject (CoreDataProperties)

+ (NSFetchRequest<NGNProject *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNProject"];
}

@dynamic idx;
@dynamic info;
@dynamic name;
@dynamic number;
@dynamic positions;
@dynamic user;

@end

@implementation NGNProject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"number", @"info"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    //Adding user object relationship
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"idx";
    [userMapping addAttributesFromDictionary:@{@"idx": @"user"}];
    
    [mapping addRelationshipMapping:userMapping forProperty:@"user" keyPath:nil];
    
    return mapping;
}

@end
