//
//  NGNFireSafetyCategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFireSafetyCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFireSafetyCategory"];
}

@dynamic idx;
@dynamic name;
@dynamic positions;
@dynamic rooms;

@end
