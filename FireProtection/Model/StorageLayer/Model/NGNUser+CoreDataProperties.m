//
//  NGNUser+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNUser+CoreDataProperties.h"

@implementation NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNUser"];
}

@dynamic idx;
@dynamic name;
@dynamic password;
@dynamic projects;
@dynamic substances;

@end
