//
//  NGNFunctionalFireSafetySubcategory+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetySubcategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFunctionalFireSafetySubcategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetySubcategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;
@property (nullable, nonatomic, retain) NGNFunctionalFireSafetyCategory *functionalFireCategory;

@end

@interface NGNFunctionalFireSafetySubcategory (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

@end

NS_ASSUME_NONNULL_END
