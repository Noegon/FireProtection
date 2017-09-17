//
//  NGNUser+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNUser+CoreDataProperties.h"
#import "NGNCommonConstants.h"

@implementation NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNUser"];
}

@dynamic idx;
@dynamic name;
@dynamic registrationDate;
@dynamic projects;
@dynamic positions;
@dynamic rooms;
@dynamic apertureGroups;
@dynamic substances;
@dynamic substancePiles;

@end

@implementation NGNUser (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:kNGNModelDateFormat];
    
    FEMAttribute *registrationDate = [[FEMAttribute alloc] initWithProperty:@"registrationDate" keyPath:@"registration_date" map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [formatter dateFromString:value];
        }
        return nil;
    } reverseMap:^id(id value) {
        return [formatter stringFromDate:value];
    }];
    
    [mapping addAttribute:registrationDate];
    
    return mapping;
}

@end
