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

static NSString *const kNGNEntitiesParamsManagerEmptyString = @"";

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
    } else if ([service isMemberOfClass:NGNSubstanceService.class]) {
        result = kNGNSubstanceEndpoint;
    } else if ([service isMemberOfClass:NGNSubstancePileService.class]) {
        result = kNGNSubstancePileEndpoint;
    } else if ([service isMemberOfClass:NGNFireResistanceRankService.class]) {
        result = kNGNFireResistanceRankEndpoint;
    } else if ([service isMemberOfClass:NGNFireSafetyCategoryService.class]) {
        result = kNGNFireSafetyCategoryEndpoint;
    } else if ([service isMemberOfClass:NGNFunctionalFireSafetyCategoryService.class]) {
        result = kNGNFunctionalFireSafetyCategoryEndpoint;
    } else if ([service isMemberOfClass:NGNFunctionalFireSafetySubcategoryService.class]) {
        result = kNGNFunctionalFireSafetySubcategoryEndpoint;
    } else if ([service isMemberOfClass:NGNSubstanceTypeService.class]) {
        result = kNGNSubstanceTypeEndpoint;
    } else if ([service isMemberOfClass:NGNMinimumREIConstructionTypeService.class]) {
        result = kNGNMinimumREIConstructionTypeEndpoint;
    }
    return result;
}

+ (NSString *)parentEntityByEntityService:(id<NGNServiceProtocol>)service {
    NSString *result = nil;
    if ([service isMemberOfClass:NGNUserService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNProjectService.class]) {
        result = @"user";
    } else if ([service isMemberOfClass:NGNPositionService.class]) {
        result = @"project";
    } else if ([service isMemberOfClass:NGNRoomService.class]) {
        result = @"position";
    } else if ([service isMemberOfClass:NGNApertureGroupService.class]) {
        result = @"room";
    } else if ([service isMemberOfClass:NGNSubstanceService.class]) {
        result = @"user";
    } else if ([service isMemberOfClass:NGNSubstancePileService.class]) {
        result = @"room";
    } else if ([service isMemberOfClass:NGNFireResistanceRankService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNFireSafetyCategoryService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNFunctionalFireSafetyCategoryService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNFunctionalFireSafetySubcategoryService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNSubstanceTypeService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    } else if ([service isMemberOfClass:NGNMinimumREIConstructionTypeService.class]) {
        result = kNGNEntitiesParamsManagerEmptyString;
    }
    return result;
}

@end
