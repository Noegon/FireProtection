//
//  NGNUser+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNUser+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *registrationDate;
@property (nullable, nonatomic, retain) NSSet<NGNProject *> *projects;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;
@property (nullable, nonatomic, retain) NSSet<NGNRoom *> *rooms;
@property (nullable, nonatomic, retain) NSSet<NGNApertureGroup *> *apertureGroups;
@property (nullable, nonatomic, retain) NSSet<NGNSubstance *> *substances;
@property (nullable, nonatomic, retain) NSSet<NGNSubstancePile *> *substancePiles;

@end

@interface NGNUser (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(NGNProject *)value;
- (void)removeProjectsObject:(NGNProject *)value;
- (void)addProjects:(NSSet<NGNProject *> *)values;
- (void)removeProjects:(NSSet<NGNProject *> *)values;

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

- (void)addRoomsObject:(NGNRoom *)value;
- (void)removeRoomsObject:(NGNRoom *)value;
- (void)addRooms:(NSSet<NGNRoom *> *)values;
- (void)removeRooms:(NSSet<NGNRoom *> *)values;

- (void)addApertureGroupsObject:(NGNApertureGroup *)value;
- (void)removeApertureGroupsObject:(NGNApertureGroup *)value;
- (void)addApertureGroups:(NSSet<NGNApertureGroup *> *)values;
- (void)removeApertureGroups:(NSSet<NGNApertureGroup *> *)values;

- (void)addSubstancesObject:(NGNSubstance *)value;
- (void)removeSubstancesObject:(NGNSubstance *)value;
- (void)addSubstances:(NSSet<NGNSubstance *> *)values;
- (void)removeSubstances:(NSSet<NGNSubstance *> *)values;

- (void)addSubstancePilesObject:(NGNSubstance *)value;
- (void)removeSubstancePilesObject:(NGNSubstance *)value;
- (void)addSubstancePiles:(NSSet<NGNSubstance *> *)values;
- (void)removeSubstancePiles:(NSSet<NGNSubstance *> *)values;

@end

@interface NGNUser (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
