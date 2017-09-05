//
//  NGNFireSafetyCategory+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireSafetyCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFireSafetyCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;
@property (nullable, nonatomic, retain) NSSet<NGNRoom *> *rooms;

@end

@interface NGNFireSafetyCategory (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

- (void)addRoomsObject:(NGNRoom *)value;
- (void)removeRoomsObject:(NGNRoom *)value;
- (void)addRooms:(NSSet<NGNRoom *> *)values;
- (void)removeRooms:(NSSet<NGNRoom *> *)values;

@end

NS_ASSUME_NONNULL_END
