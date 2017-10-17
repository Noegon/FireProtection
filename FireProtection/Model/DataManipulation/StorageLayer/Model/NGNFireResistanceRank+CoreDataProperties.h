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

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, copy) NSNumber *bearingElementR;
@property (nullable, nonatomic, copy) NSNumber *selfBearingElementRE;
@property (nullable, nonatomic, copy) NSNumber *outerNonBearingWallE;
@property (nullable, nonatomic, copy) NSNumber *floorCeilingREI;
@property (nullable, nonatomic, copy) NSNumber *coveringRE;
@property (nullable, nonatomic, copy) NSNumber *fermBeanR;
@property (nullable, nonatomic, copy) NSNumber *stairWallREI;
@property (nullable, nonatomic, copy) NSNumber *stairwayR;
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
