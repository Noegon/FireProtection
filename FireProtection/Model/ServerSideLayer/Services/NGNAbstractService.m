//
//  NGNAbstractService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNAbstractService.h"

@implementation NGNAbstractService

- (instancetype)init {
    if (self = [super init]) {
        _basicService = [[NGNBasicService alloc] init];
    }
    return self;
}

#pragma mark - NGNServiceProtocol

- (void)fetchEntities:(void(^)(NSArray *entity))completitionBlock {}

- (void)fetchEntityById:(NSString *)entytyId
      completitionBlock:(void(^)(NSDictionary *entity))completitionBlock {}

@end
