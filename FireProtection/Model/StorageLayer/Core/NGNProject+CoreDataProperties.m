//
//  NGNProject+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNProject+CoreDataProperties.h"

@implementation NGNProject (CoreDataProperties)

+ (NSFetchRequest<NGNProject *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNProject"];
}

@dynamic idx;
@dynamic name;
@dynamic number;
@dynamic info;
@dynamic user;
@dynamic positions;

@end
