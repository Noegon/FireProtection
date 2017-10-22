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

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *density;
@property (nullable, nonatomic, copy) NSNumber *requiredAirAmount;
@property (nullable, nonatomic, copy) NSNumber *heatOfCombusion;
@property (nullable, nonatomic, copy) NSNumber *criticalRadiationDensity;
@property (nullable, nonatomic, copy) NSNumber *flameSpeed;
@property (nullable, nonatomic, copy) NSNumber *burningRate;
@property (nullable, nonatomic, copy) NSNumber *molecularWeight; //g/mol
@property (nullable, nonatomic, copy) NSNumber *splashPoint; //deg Cel
@property (nullable, nonatomic, copy) NSNumber *carbonAthoms;
@property (nullable, nonatomic, copy) NSNumber *hydrogenAthoms;
@property (nullable, nonatomic, copy) NSNumber *oxygenAthoms;
@property (nullable, nonatomic, copy) NSNumber *galoidsAthoms;
@property (nullable, nonatomic, retain) NGNSubstanceType *substanceType;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NSSet<NGNSubstancePile *> *substancePiles;

@end

@interface NGNSubstance (AdditionalMethods)

- (NSString *)info;

@end

@interface NGNSubstance (CoreDataGeneratedAccessors)

- (void)addSubstancePilesObject:(NGNSubstancePile *)value;
- (void)removeSubstancePilesObject:(NGNSubstancePile *)value;
- (void)addSubstancePiles:(NSSet<NGNSubstancePile *> *)values;
- (void)removeSubstancePiles:(NSSet<NGNSubstancePile *> *)values;

@end

@interface NGNSubstance (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
