//
//  NGNBasicService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;

@interface NGNBasicService : NSObject

- (NSURLSession *)createUrlSession;
- (NSURL *)makeResourceURLWithServerUrl:(NSString *)servrerURL
                   resourcePathElements:(NSArray<NSString *>*)resourcePathElements;
- (void)executeCompletionBlock:(void(^)(id object, NSError *error))completionBlock object:(id)object error:(NSError *)error;

@end

@interface NGNBasicService (NGNOperationsWithEntities)

- (void)fetchEntitiesWithEntityPathElements:(NSArray *)pathElements
                          completionBlock:(void(^)(NSArray *entities, NSError *error))completionBlock;

- (void)fetchSingleEntityWithEntityPathElements:(NSArray *)pathElements
                              completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock;

- (void)addEntity:(NSDictionary *)entity
     pathElements:(NSArray *)pathElements
completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock;

- (void)updateEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock;

- (void)deleteEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock;

- (void)deleteEntities:(NSArray *)entities
          pathElements:(NSArray *)pathElements
       completionBlock:(void(^)(NSArray *entities, NSError *error))completionBlock;

@end
