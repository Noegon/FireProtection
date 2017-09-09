//
//  NGNFunctionalFireSafetySubcategory+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetySubcategory+CoreDataProperties.h"

@implementation NGNFunctionalFireSafetySubcategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetySubcategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNFunctionalFireSafetySubcategory"];
}

@dynamic idx;
@dynamic name;
@dynamic info;
@dynamic positions;
@dynamic functionalFireCategory;

@end
