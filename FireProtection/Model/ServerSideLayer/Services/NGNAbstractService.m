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

- (void)fetchEntities:(void(^)(NSArray *entity))completionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[[self entityEndpoint]]
                                           completionBlock:completionBlock];
}

- (void)fetchEntitiesByParentEntityId:(NSNumber *)parentEntityId
                      completionBlock:(void(^)(NSArray *entity))completionBlock {
    [self fetchEntitiesWithAdditionalParameters:@{[self parentEntity]: parentEntityId.stringValue}
                                completionBlock:completionBlock];
}

- (void)fetchEntitiesWithAdditionalParameters:(NSDictionary<NSString *, NSString *> *)additionalParameters
                              completionBlock:(void(^)(NSArray *entities))completionBlock {
    NSMutableString *additionalParamsString = [@"?" mutableCopy];
    for (NSString *key in additionalParameters.allKeys) {
        if (![additionalParameters[key].class isKindOfClass:NSNull.class]) {
            [additionalParamsString appendString:key];
            [additionalParamsString appendString:@"="];
            [additionalParamsString appendString:additionalParameters[key]];
            [additionalParamsString appendString:@"&"];
        }
    }
    //Cut last ampersand
    NSString *finalParams = [additionalParamsString substringToIndex:additionalParamsString.length - 1];
    NSString *correctedEndpoint = [[self entityEndpoint] substringToIndex:[self entityEndpoint].length - 1];
    [self.basicService fetchEntitiesWithEntityPathElements:@[correctedEndpoint, finalParams]
                                               completionBlock:completionBlock];
}

- (void)fetchEntityById:(NSNumber *)entityId
        completionBlock:(void(^)(NSDictionary *entity))completionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[[self entityEndpoint], entityId.stringValue]
                                               completionBlock:completionBlock];
}

- (void)addEntity:(NSDictionary *)entity
  completionBlock:(void(^)(NSDictionary *entity))completionBlock {
    [self.basicService addEntity:entity
                    pathElements:@[[self entityEndpoint]]
                 completionBlock:completionBlock];
}

- (void)updateEntity:(NSDictionary *)entity
   completionBlock:(void(^)(NSDictionary *entity))completionBlock {
    [self.basicService updateEntity:entity
                       pathElements:@[[self entityEndpoint], [entity[@"id"] stringValue]]
                    completionBlock:completionBlock];
}

- (void)deleteEntity:(NSDictionary *)entity
   completionBlock:(void(^)(NSDictionary *entity))completionBlock {
    [self.basicService deleteEntity:entity
                       pathElements:@[[self entityEndpoint], [entity[@"id"] stringValue]]
                    completionBlock:completionBlock];
}

@end
