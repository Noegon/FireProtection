//
//  NGNApertureGroup+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNApertureGroup+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNApertureGroup (CoreDataProperties)

+ (NSFetchRequest<NGNApertureGroup *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *amount;
@property (nullable, nonatomic, copy) NSNumber *height;
@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSNumber *width;
@property (nullable, nonatomic, retain) NGNRoom *room;

@end

NS_ASSUME_NONNULL_END
