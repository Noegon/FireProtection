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
- (void)executeCompletitionBlock:(void(^)(id object))completitionBlock object:(id)object;

@end

@interface NGNBasicService (NGNOperationsWithEntities)

- (void)fetchEntitiesWithEntityPathElements:(NSArray *)pathElements
                          completitionBlock:(void(^)(NSArray *entities))completitionBlock;

- (void)fetchSingleEntityWithEntityPathElements:(NSArray *)pathElements
                              completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

- (void)addEntity:(NSDictionary *)entity
     pathElements:(NSArray *)pathElements
completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

- (void)updateEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

- (void)deleteEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

@end
