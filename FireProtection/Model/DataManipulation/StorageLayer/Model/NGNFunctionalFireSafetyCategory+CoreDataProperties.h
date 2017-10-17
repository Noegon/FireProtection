//
//  NGNFunctionalFireSafetyCategory+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNFunctionalFireSafetyCategory+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNFunctionalFireSafetyCategory (CoreDataProperties)

+ (NSFetchRequest<NGNFunctionalFireSafetyCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *idx;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<NGNFunctionalFireSafetySubcategory *> *functionalFireSubcategories;

@end

@interface NGNFunctionalFireSafetyCategory (CoreDataGeneratedAccessors)

- (void)addFunctionalFireSubategoriesObject:(NGNFunctionalFireSafetySubcategory *)value;
- (void)removeFunctionalFireSubategoriesObject:(NGNFunctionalFireSafetySubcategory *)value;
- (void)addFunctionalFireSubategories:(NSSet<NGNFunctionalFireSafetySubcategory *> *)values;
- (void)removeFunctionalFireSubategories:(NSSet<NGNFunctionalFireSafetySubcategory *> *)values;

@end

@interface NGNFunctionalFireSafetyCategory (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
