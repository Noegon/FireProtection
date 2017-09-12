//
//  NGNEntitiesParamsManager.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 12.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NGNServiceProtocol;

@interface NGNEntitiesParamsManager : NSObject

+ (NSString *)endpointByEntityService:(id<NGNServiceProtocol>)service;
+ (NSString *)parentEntityByEntityService:(id<NGNServiceProtocol>)service;

@end
