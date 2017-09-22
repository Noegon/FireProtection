//
//  NGNAbstractService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNAbstractService.h"
#import "NGNEntitiesParamsManager.h"

@implementation NGNAbstractService

- (instancetype)init {
    if (self = [super init]) {
        _basicService = [[NGNBasicService alloc] init];
    }
    return self;
}

#pragma mark - NGNServiceProtocol

- (NSString *)entityEndpoint {
    return [NGNEntitiesParamsManager endpointByEntityService:self];
}

- (NSString *)parentEntity {
    return [NGNEntitiesParamsManager parentEntityByEntityService:self];
}

- (void)fetchEntities:(void(^)(NSArray *entity, NSError *error))completionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[[self entityEndpoint]]
                                           completionBlock:completionBlock];
}

- (void)fetchEntitiesByParentEntityId:(NSNumber *)parentEntityId
                      completionBlock:(void(^)(NSArray *entity, NSError *error))completionBlock {
    if (![[self parentEntity] isEqualToString:kNGNAdditionalSymbolsEmptyString]) {
        [self fetchEntitiesWithAdditionalParameters:@{[self parentEntity]: parentEntityId.stringValue}
                                    completionBlock:completionBlock];
    } else {
        @throw ([NSString stringWithFormat:@"(%@) - %@",
                 self.class,
                 @"Method (fetchEntitiesByParentEntityId:completionBlock:) not allowed: no parent entity."]);
    }
}

- (void)fetchEntitiesWithAdditionalParameters:(NSDictionary<NSString *, NSString *> *)additionalParameters
                              completionBlock:(void(^)(NSArray *entities, NSError *error))completionBlock {
    NSMutableString *additionalParamsString = [kNGNAdditionalSymbolsQuestionMark mutableCopy];
    for (NSString *key in additionalParameters.allKeys) {
        if (![additionalParameters[key].class isKindOfClass:NSNull.class]) {
            [additionalParamsString appendString:key];
            [additionalParamsString appendString:kNGNAdditionalSymbolsEquals];
            [additionalParamsString appendString:additionalParameters[key]];
            [additionalParamsString appendString:kNGNAdditionalSymbolsAmpersand];
        }
    }
    //Cut last ampersand
    NSString *finalParams = [additionalParamsString substringToIndex:additionalParamsString.length - 1];
    NSString *correctedEndpoint = [[self entityEndpoint] substringToIndex:[self entityEndpoint].length - 1];
    [self.basicService fetchEntitiesWithEntityPathElements:@[correctedEndpoint, finalParams]
                                               completionBlock:completionBlock];
}

- (void)fetchEntityById:(NSNumber *)entityId
        completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[[self entityEndpoint], entityId.stringValue]
                                               completionBlock:completionBlock];
}

- (void)addEntity:(NSDictionary *)entity
  completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    [self.basicService addEntity:entity
                    pathElements:@[[self entityEndpoint]]
                 completionBlock:completionBlock];
}

- (void)updateEntity:(NSDictionary *)entity
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    [self.basicService updateEntity:entity
                       pathElements:@[[self entityEndpoint], [entity[kNGNResponseObjectsParametersId] stringValue]]
                    completionBlock:completionBlock];
}

- (void)deleteEntity:(NSDictionary *)entity
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    [self.basicService deleteEntity:entity
                       pathElements:@[[self entityEndpoint], [entity[kNGNResponseObjectsParametersId] stringValue]]
                    completionBlock:completionBlock];
}

/**
 Method delets all entities of current type that belongs to user with current Id
 */
- (void)deleteEntities:(NSArray *)entities
     withParameterName:(NSString *)parameterName
           parameterValue:(NSString *)parameterValue
       completionBlock:(void(^)(NSArray *entities, NSError *error))completionBlock {
    [self.basicService deleteEntities:entities
                       pathElements:@[[self entityEndpoint],
                                      [NSString stringWithFormat:@"?%@=%@", parameterName, parameterValue]]
                    completionBlock:completionBlock];
}

@end
