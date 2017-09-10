//
//  NGNFireResistanceRank+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFireResistanceRank+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFireResistanceRank (CoreDataProperties)

+ (NSFetchRequest<NGNFireResistanceRank *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, copy) NSDecimalNumber *bearingElementR;
@property (nullable, nonatomic, copy) NSDecimalNumber *selfBearingElementRE;
@property (nullable, nonatomic, copy) NSDecimalNumber *outerNonBearingWallE;
@property (nullable, nonatomic, copy) NSDecimalNumber *floorCeilingREI;
@property (nullable, nonatomic, copy) NSDecimalNumber *coveringRE;
@property (nullable, nonatomic, copy) NSDecimalNumber *fermBeanR;
@property (nullable, nonatomic, copy) NSDecimalNumber *stairWallREI;
@property (nullable, nonatomic, copy) NSDecimalNumber *stairwayR;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;

@end

@interface NGNFireResistanceRank (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

@end

@interface NGNFireResistanceRank (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
