//
//  NGNServerSideLayerConstants.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const NGNOrderEndpoint = @"order/";
static NSString *const NGNCatalogEndpoint = @"catalog/";
static NSString *const NGNGoodsOrderEndpoint = @"goodsOrder/";
static NSString *const NGNProfileEndpoint = @"profile/";
static NSString *const NGNServerURL = @"http://localhost:3000/";

#pragma mark - HTTP methods

static NSString *const NGNHTTPMethodGET = @"GET";
static NSString *const NGNHTTPMethodPOST = @"POST";
static NSString *const NGNHTTPMethodPUT = @"PUT";
static NSString *const NGNHTTPMethodDELETE = @"DELETE";

#pragma mark - HTTP headers

static NSString *const NGNHTTPHeaderAccept = @"Accept";
static NSString *const NGNHTTPHeaderContentType = @"Content-type";

#pragma mark - HTTP data types

static NSString *const NGNHTTPDataTypeJSON = @"application/json";

@interface NGNServerSideLayerConstants : NSObject

@end
