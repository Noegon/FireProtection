//
//  NGNUserMO.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 10.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NGNManagedObjectMappingProtocol.h"

@class NGNProject, NGNSubstance;

NS_ASSUME_NONNULL_BEGIN

@interface NGNUserMO : NSManagedObject

@end

@interface NGNUserMO (CoreDataProperties)

+ (NSFetchRequest<NGNUserMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, retain) NSSet<NGNProject *> *projects;
@property (nullable, nonatomic, retain) NSSet<NGNSubstance *> *substances;

@end

@interface NGNUserMO (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(NGNProject *)value;
- (void)removeProjectsObject:(NGNProject *)value;
- (void)addProjects:(NSSet<NGNProject *> *)values;
- (void)removeProjects:(NSSet<NGNProject *> *)values;

- (void)addSubstancesObject:(NGNSubstance *)value;
- (void)removeSubstancesObject:(NGNSubstance *)value;
- (void)addSubstances:(NSSet<NGNSubstance *> *)values;
- (void)removeSubstances:(NSSet<NGNSubstance *> *)values;

@end

@interface NGNUserMO (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
