//
//  NGNSubstance+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstance+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNSubstance (CoreDataProperties)

+ (NSFetchRequest<NGNSubstance *> *)fetchRequest;

@property (nonatomic) double requiredAirAmount;
@property (nullable, nonatomic, copy) NSNumber *heatOfCombusion;
@property (nullable, nonatomic, copy) NSNumber *flameSpeed;
@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *density;
@property (nullable, nonatomic, copy) NSNumber *burningRate;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NSSet<NGNSubstancePile *> *substanceSets;
@property (nullable, nonatomic, retain) NGNSubstanceType *substanceType;

@end

@interface NGNSubstance (CoreDataGeneratedAccessors)

- (void)addSubstanceSetsObject:(NGNSubstancePile *)value;
- (void)removeSubstanceSetsObject:(NGNSubstancePile *)value;
- (void)addSubstanceSets:(NSSet<NGNSubstancePile *> *)values;
- (void)removeSubstanceSets:(NSSet<NGNSubstancePile *> *)values;

@end

NS_ASSUME_NONNULL_END
