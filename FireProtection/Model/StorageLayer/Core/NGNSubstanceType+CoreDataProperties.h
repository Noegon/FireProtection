//
//  NGNSubstanceType+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstanceType+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNSubstanceType (CoreDataProperties)

+ (NSFetchRequest<NGNSubstanceType *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NGNSubstance *> *substances;

@end

@interface NGNSubstanceType (CoreDataGeneratedAccessors)

- (void)addSubstancesObject:(NGNSubstance *)value;
- (void)removeSubstancesObject:(NGNSubstance *)value;
- (void)addSubstances:(NSSet<NGNSubstance *> *)values;
- (void)removeSubstances:(NSSet<NGNSubstance *> *)values;

@end

NS_ASSUME_NONNULL_END
