//
//  NGNSubstance+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstance+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *density;
@property (nullable, nonatomic, copy) NSNumber *requiredAirAmount;
@property (nullable, nonatomic, copy) NSNumber *heatOfCombusion;
@property (nullable, nonatomic, copy) NSNumber *flameSpeed;
@property (nullable, nonatomic, copy) NSNumber *burningRate;
@property (nullable, nonatomic, retain) NGNSubstanceType *substanceType;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NSSet<NGNSubstancePile *> *substanceSets;

@end

@interface NGNSubstance (AdditionalMethods)

- (NSString *)info;

@end

@interface NGNSubstance (CoreDataGeneratedAccessors)

- (void)addSubstanceSetsObject:(NGNSubstancePile *)value;
- (void)removeSubstanceSetsObject:(NGNSubstancePile *)value;
- (void)addSubstanceSets:(NSSet<NGNSubstancePile *> *)values;
- (void)removeSubstanceSets:(NSSet<NGNSubstancePile *> *)values;

@end

@interface NGNSubstance (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
