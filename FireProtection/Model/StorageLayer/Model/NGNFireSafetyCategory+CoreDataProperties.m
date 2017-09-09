//
//  NGNFireSafetyCategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFireSafetyCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFireSafetyCategory"];
}

@dynamic idx;
@dynamic name;
@dynamic info;
@dynamic rooms;
@dynamic positions;

@end
