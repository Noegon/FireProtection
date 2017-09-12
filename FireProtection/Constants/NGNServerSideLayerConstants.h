//
//  NGNServerSideLayerConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kNGNUserEndpoint = @"user/";
static NSString *const kNGNProjectEndpoint = @"project/";
static NSString *const kNGNPositionEndpoint = @"goodsOrder/";
static NSString *const kNGNRoomEndpoint = @"room/";
static NSString *const kNGNApertureGroupEndpoint = @"aperture_group/";
static NSString *const kNGNSubstanceEndpoint = @"substance/";
static NSString *const kNGNSubstancePileEndpoint = @"substance_pile/";
static NSString *const kNGNFireSafetyCategoryEndpoint = @"fire_safety_category/";
static NSString *const kNGNSubstanceTypeEndpoint = @"substance_type/";
static NSString *const kNGNFireResistanceRankEndpoint = @"fire_resistance_rank/";
static NSString *const kNGNFunctionalFireSafetyCategoryEndpoint = @"functional_fire_safety_category/";
static NSString *const kNGNFunctionalFireSafetySubcategoryEndpoint = @"functional_fire_safety_subcategory/";
static NSString *const kNGNMinimumREIConstructionTypeEndpoint = @"minimum_rei_construction_type/";
static NSString *const kNGNServerURL = @"http://localhost:3000/";

#pragma mark - HTTP methods

static NSString *const kNGNHTTPMethodGET = @"GET";
static NSString *const kNGNHTTPMethodPOST = @"POST";
static NSString *const kNGNHTTPMethodPUT = @"PUT";
static NSString *const kNGNHTTPMethodDELETE = @"DELETE";

#pragma mark - HTTP headers

static NSString *const kNGNHTTPHeaderAccept = @"Accept";
static NSString *const kNGNHTTPHeaderContentType = @"Content-type";

#pragma mark - HTTP data types

static NSString *const kNGNHTTPDataTypeJSON = @"application/json";

@interface NGNServerSideLayerConstants : NSObject

@end
