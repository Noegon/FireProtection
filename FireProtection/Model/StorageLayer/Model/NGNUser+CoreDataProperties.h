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
@property (nullable, nonatomic, retain) NSSet<NGNProject *> *projects;
@property (nullable, nonatomic, retain) NSSet<NGNSubstance *> *substances;

@end

@interface NGNUser (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(NGNProject *)value;
- (void)removeProjectsObject:(NGNProject *)value;
- (void)addProjects:(NSSet<NGNProject *> *)values;
- (void)removeProjects:(NSSet<NGNProject *> *)values;

- (void)addSubstancesObject:(NGNSubstance *)value;
- (void)removeSubstancesObject:(NGNSubstance *)value;
- (void)addSubstances:(NSSet<NGNSubstance *> *)values;
- (void)removeSubstances:(NSSet<NGNSubstance *> *)values;

@end

@interface NGNUser (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
