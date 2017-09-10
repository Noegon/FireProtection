//
//  NGNMinimumREIConstructionType+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNMinimumREIConstructionType+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNMinimumREIConstructionType (CoreDataProperties)

+ (NSFetchRequest<NGNMinimumREIConstructionType *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NGNRoom *> *rooms;

@end

@interface NGNMinimumREIConstructionType (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(NGNRoom *)value;
- (void)removeRoomsObject:(NGNRoom *)value;
- (void)addRooms:(NSSet<NGNRoom *> *)values;
- (void)removeRooms:(NSSet<NGNRoom *> *)values;

@end

@interface NGNMinimumREIConstructionType (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
