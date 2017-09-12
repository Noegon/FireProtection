//
//  NGNEntitiesParamsManager.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 12.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNEntitiesParamsManager.h"
#import "NGNServerSideLayerConstants.h"
#import "NGNServerLayerServices.h"

@implementation NGNEntitiesParamsManager

+ (NSString *)endpointByEntityService:(id<NGNServiceProtocol>)service {
    NSString *result = nil;
    if ([service isMemberOfClass:NGNUserService.class]) {
        result = kNGNUserEndpoint;
    } else if ([service isMemberOfClass:NGNProjectService.class]) {
        result = kNGNProjectEndpoint;
    } else if ([service isMemberOfClass:NGNPositionService.class]) {
        result = kNGNPositionEndpoint;
    } else if ([service isMemberOfClass:NGNRoomService.class]) {
        result = kNGNRoomEndpoint;
    } else if ([service isMemberOfClass:NGNApertureGroupService.class]) {
        result = kNGNApertureGroupEndpoint;
    }
    return result;
}

+ (NSString *)parentEntityByEntityService:(id<NGNServiceProtocol>)service {
    NSString *result = nil;
    if ([service isMemberOfClass:NGNUserService.class]) {
        result = @"";
    } else if ([service isMemberOfClass:NGNProjectService.class]) {
        result = @"user";
    } else if ([service isMemberOfClass:NGNPositionService.class]) {
        result = @"project";
    } else if ([service isMemberOfClass:NGNRoomService.class]) {
        result = @"position";
    } else if ([service isMemberOfClass:NGNApertureGroupService.class]) {
        result = @"room";
    }
    return result;
}

@end
