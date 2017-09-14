//
//  NGNSubstancePile+CoreDataProperties.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstancePile+CoreDataClass.h"
#import "NGNManagedObjectMappingProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNSubstancePile (CoreDataProperties)

+ (NSFetchRequest<NGNSubstancePile *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDecimalNumber *idx;
@property (nullable, nonatomic, copy) NSNumber *projectionSquare;
@property (nullable, nonatomic, copy) NSNumber *mediumPileHeight;
@property (nullable, nonatomic, copy) NSNumber *maxPileHeight;
@property (nullable, nonatomic, retain) NGNUser *user;
@property (nullable, nonatomic, retain) NGNRoom *room;
@property (nullable, nonatomic, retain) NGNSubstance *substance;

-(NSNumber *)mass;

@end

@interface NGNSubstancePile (Mapping) <NGNManagedObjectMappingProtocol>

@end

NS_ASSUME_NONNULL_END
