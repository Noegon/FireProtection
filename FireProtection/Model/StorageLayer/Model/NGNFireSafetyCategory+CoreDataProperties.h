//
//  NGNFireSafetyCategory+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireSafetyCategory+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFireSafetyCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, retain) NSSet<NGNRoom *> *rooms;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;

@end

@interface NGNFireSafetyCategory (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(NGNRoom *)value;
- (void)removeRoomsObject:(NGNRoom *)value;
- (void)addRooms:(NSSet<NGNRoom *> *)values;
- (void)removeRooms:(NSSet<NGNRoom *> *)values;

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

@end

@interface NGNFireSafetyCategory (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
