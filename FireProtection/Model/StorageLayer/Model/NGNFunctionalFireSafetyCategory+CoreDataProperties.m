//
//  NGNFunctionalFireSafetyCategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetyCategory+CoreDataProperties.h"

@implementation NGNFunctionalFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetyCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFunctionalFireSafetyCategory"];
}

@dynamic idx;
@dynamic info;
@dynamic name;
@dynamic positions;

@end
