//
//  NGNServiceProtocol.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NGNServiceProtocol <NSObject>

@optional
- (void)fetchEntities:(void(^)(NSArray *entity))completionBlock;

- (void)fetchEntitiesByParentEntityId:(NSNumber *)parentEntityId
                      completionBlock:(void(^)(NSArray *entity))completionBlock;

- (void)fetchEntitiesWithAdditionalParameters:(NSDictionary<NSString *, NSString *> *)additionalParameters
                              completionBlock:(void(^)(NSArray *entities))completionBlock;

- (void)fetchEntityById:(NSNumber *)entityId
      completionBlock:(void(^)(NSDictionary *entity))completionBlock;

- (void)addEntity:(NSDictionary *)entity completionBlock:(void(^)(NSDictionary *entity))completionBlock;

- (void)updateEntity:(NSDictionary *)entity completionBlock:(void(^)(NSDictionary *entity))completionBlock;

- (void)deleteEntity:(NSDictionary *)entity completionBlock:(void(^)(NSDictionary *entity))completionBlock;

@end
