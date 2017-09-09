//
//  NGNApertureGroup+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNApertureGroup+CoreDataProperties.h"

@implementation NGNApertureGroup (CoreDataProperties)

+ (NSFetchRequest<NGNApertureGroup *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNApertureGroup"];
}

@dynamic amount;
@dynamic height;
@dynamic idx;
@dynamic width;
@dynamic room;

@end
