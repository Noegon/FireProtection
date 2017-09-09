//
//  NGNProject+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNProject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNProject (CoreDataProperties)

+ (NSFetchRequest<NGNProject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, retain) NSSet<NGNPosition *> *positions;
@property (nullable, nonatomic, retain) NGNUser *user;

@end

@interface NGNProject (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NGNPosition *)value;
- (void)removePositionsObject:(NGNPosition *)value;
- (void)addPositions:(NSSet<NGNPosition *> *)values;
- (void)removePositions:(NSSet<NGNPosition *> *)values;

@end

NS_ASSUME_NONNULL_END
