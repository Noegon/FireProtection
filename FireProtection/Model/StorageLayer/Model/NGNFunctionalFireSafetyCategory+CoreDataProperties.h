//
//  NGNFunctionalFireSafetyCategory+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetyCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFunctionalFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetyCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;

@end

@interface NGNFunctionalFireSafetyCategory (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

@end

NS_ASSUME_NONNULL_END
