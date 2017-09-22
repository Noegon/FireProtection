//
//  NGNApertureGroup+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNApertureGroup+CoreDataClass.h"
#import "NGNUser+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGNApertureGroup (CoreDataProperties)

+ (NSFetchRequest<NGNApertureGroup *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSNumber *height;
@property (nullable, nonatomic, copy) NSNumber *width;
@property (nullable, nonatomic, copy) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NGNRoom *room;

@end

@interface NGNApertureGroup (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
