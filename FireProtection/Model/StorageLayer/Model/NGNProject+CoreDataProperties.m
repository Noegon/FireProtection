//
//  NGNProject+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNProject+CoreDataProperties.h"

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
