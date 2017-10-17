//
//  NGNRoom+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNRoom+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGNRoom (CoreDataProperties)

+ (NSFetchRequest<NGNRoom *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *height;
@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, copy) NSNumber *square;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NGNFireSafetyCategory *fireSafetyCategory;
@property (nullable, nonatomic, retain) NGNMinimumREIConstructionType *minimumREIConstructionType;
@property (nullable, nonatomic, retain) NGNPosition *position;
@property (nullable, nonatomic, retain) NSSet<NGNApertureGroup *> *apertureGroups;
@property (nullable, nonatomic, retain) NSSet<NGNSubstancePile *> *substancePiles;

@end

@interface NGNRoom (CoreDataGeneratedAccessors)

- (void)addApertureGroupsObject:(NGNApertureGroup *)value;
- (void)removeApertureGroupsObject:(NGNApertureGroup *)value;
- (void)addApertureGroups:(NSSet<NGNApertureGroup *> *)values;
- (void)removeApertureGroups:(NSSet<NGNApertureGroup *> *)values;

- (void)addSubstancePilesObject:(NGNSubstancePile *)value;
- (void)removeSubstancePilesObject:(NGNSubstancePile *)value;
- (void)addSubstancePiles:(NSSet<NGNSubstancePile *> *)values;
- (void)removeSubstancePiles:(NSSet<NGNSubstancePile *> *)values;

@end

@interface NGNRoom (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
