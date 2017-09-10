//
//  NGNPosition+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNPosition+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGNPosition (CoreDataProperties)

+ (NSFetchRequest<NGNPosition *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *fullSquare;
@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, copy) NSNumber *structuralVolume;
@property (nullable, nonatomic, copy) NSNumber *usefulSquare;
@property (nullable, nonatomic, retain) NGNFireResistanceRank *fireResistanceRank;
@property (nullable, nonatomic, retain) NGNProject *project;
@property (nullable, nonatomic, retain) NSSet<NGNRoom *> *rooms;
@property (nullable, nonatomic, retain) NGNFunctionalFireSafetySubcategory *functionalFireSubcategory;
@property (nullable, nonatomic, retain) NGNFireSafetyCategory *fireSafetyCategory;

@end

@interface NGNPosition (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(NGNRoom *)value;
- (void)removeRoomsObject:(NGNRoom *)value;
- (void)addRooms:(NSSet<NGNRoom *> *)values;
- (void)removeRooms:(NSSet<NGNRoom *> *)values;

@end

@interface NGNPosition (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
