//
//  NGNServiceProtocol.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NGNServiceProtocol <NSObject>
@required
- (void)fetchEntities:(void(^)(NSArray *entity))completitionBlock;
- (void)fetchEntityById:(NSString *)entytyId
     completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

@optional
- (void)addEntity:(NSDictionary *)entity completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;
- (void)updateEntity:(NSDictionary *)entity completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;
- (void)deleteEntity:(NSDictionary *)entity completitionBlock:(void(^)(NSDictionary *entity))completitionBlock;

@end
