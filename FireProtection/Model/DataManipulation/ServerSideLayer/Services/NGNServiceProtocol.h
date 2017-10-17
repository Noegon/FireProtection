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
- (void)fetchEntities:(void(^_Nonnull)(NSArray * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)fetchEntitiesByParentEntityId:(NSNumber * _Nonnull)parentEntityId
                      completionBlock:(void(^_Nonnull)(NSArray * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)fetchEntitiesWithAdditionalParameters:(NSDictionary<NSString *, NSString *> *_Nonnull)additionalParameters
                              completionBlock:(void(^_Nonnull)(NSArray * _Nullable entities, NSError * _Nonnull error))completionBlock;

- (void)fetchEntityById:(NSNumber *_Nonnull)entityId
        completionBlock:(void(^_Nonnull)(NSDictionary * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)addEntity:(NSDictionary *_Nonnull)entity
  completionBlock:(void(^_Nonnull)(NSDictionary * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)updateEntity:(NSDictionary *_Nonnull)entity
     completionBlock:(void(^_Nonnull)(NSDictionary * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)deleteEntity:(NSDictionary *_Nonnull)entity
     completionBlock:(void(^_Nonnull)(NSDictionary * _Nullable entity, NSError * _Nonnull error))completionBlock;

- (void)deleteEntities:(NSArray *_Nullable)entities
     withParameterName:(NSString *_Nonnull)parameterName
        parameterValue:(NSString *_Nonnull)parameterValue
       completionBlock:(void(^_Nonnull)(NSArray * _Nullable entities, NSError * _Nonnull error))completionBlock;

@end
