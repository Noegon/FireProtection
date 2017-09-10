//
//  NGNUserMO.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 10.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNUserMO.h"
#import "NGNCommonConstants.h"

@implementation NGNUserMO

@end

@implementation NGNUserMO (CoreDataProperties)

+ (NSFetchRequest<NGNUserMO *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"NGNUser"];
}

@dynamic idx;
@dynamic name;
@dynamic password;
@dynamic projects;
@dynamic substances;

@end

@implementation NGNUserMO (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"password"]];
    [mapping addAttributesFromDictionary:@{@"idx": @"id"}];
    mapping.primaryKey = @"idx";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru"]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:NGNModelDateFormat];
    
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

