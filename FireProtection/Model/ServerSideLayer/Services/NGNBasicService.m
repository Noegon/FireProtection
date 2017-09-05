//
//  NGNBasicService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNBasicService.h"
#import "NGNServerSideLayerConstants.h"

typedef void (^BasicCompletitionHandler)(NSData *data, NSURLResponse *response, NSError *error);

@implementation NGNBasicService

- (NSURLSession *)createUrlSession {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (NSURL *)makeResourceURLWithServerUrl:(NSString *)servrerURL
                   resourcePathElements:(NSArray *)resourcePathElements {
    NSMutableString *finalPath = [[NSString stringWithFormat:@"%@", servrerURL] mutableCopy];
    for (id element in resourcePathElements) {
        NSString *stringfiedElement = nil;
        stringfiedElement = ![element isKindOfClass:NSString.class] ? [element stringValue] : element;
        [finalPath appendString:stringfiedElement];
        if (![stringfiedElement containsString:@"/"]) {
            [finalPath appendString:@"/"];
        }
    }
    return [NSURL URLWithString:finalPath];
}

- (void)executeCompletitionBlock:(void(^)(id object))completitionBlock object:(id)object {
    dispatch_async(dispatch_get_main_queue(), ^() {
        if (completitionBlock) {
            completitionBlock(object);
        }
    });
}

- (BasicCompletitionHandler)basicHandlerWithCompletitionBlock:(void(^)(id object))completitionBlock
                                                       entity:(id)object {
    return ^void(NSData *data, NSURLResponse *response, NSError *error) {
#warning handle error case and non 200 states code!!!
        [self executeCompletitionBlock:completitionBlock object:object];
    };
}

- (NSURLRequest *)makeRequestWithPathElements:(NSArray *)pathElements
                                   HTTPMethod:(NSString * _Nullable)HTTPMethod
                                     HTTPBody:(NSData * _Nullable)HTTPBody
                         HTTPHeadersForFields:(NSDictionary * _Nullable)HTTPHeadersForFields {
    NSURL *url = [self makeResourceURLWithServerUrl:NGNServerURL
                               resourcePathElements:pathElements];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (HTTPMethod) {
        request.HTTPMethod = HTTPMethod;
    }
    if (HTTPBody) {
        request.HTTPBody = HTTPBody;
    }
    if (HTTPHeadersForFields) {
        for (NSString *key in HTTPHeadersForFields) {
            [request setValue:HTTPHeadersForFields[key] forHTTPHeaderField:key];
        }
    }
    return request;
}

- (NSURLRequest *)makeGETRequestWithPathElements:(NSArray *)pathElements {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:NGNHTTPMethodGET
                                    HTTPBody:nil
                        HTTPHeadersForFields:nil];
}

- (NSURLRequest *)makePOSTRequestWithPathElements:(NSArray *)pathElements
                                         HTTPBody:(NSData * _Nullable)HTTPBody {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:NGNHTTPMethodPOST
                                    HTTPBody:HTTPBody
                        HTTPHeadersForFields:@{NGNHTTPHeaderContentType: NGNHTTPDataTypeJSON,
                                               NGNHTTPHeaderAccept: NGNHTTPDataTypeJSON}];
}

- (NSURLRequest *)makePUTRequestWithPathElements:(NSArray *)pathElements
                                        HTTPBody:(NSData * _Nullable)HTTPBody {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:NGNHTTPMethodPUT
                                    HTTPBody:HTTPBody
                        HTTPHeadersForFields:@{NGNHTTPHeaderContentType: NGNHTTPDataTypeJSON,
                                               NGNHTTPHeaderAccept: NGNHTTPDataTypeJSON}];
}

- (NSURLRequest *)makeDELETERequestWithPathElements:(NSArray *)pathElements {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:NGNHTTPMethodDELETE
                                    HTTPBody:nil
                        HTTPHeadersForFields:nil];
}

@end

@implementation NGNBasicService(NGNOperationsWithEntities)

- (void)basicSingleEntityOperationWithRequest:(NSURLRequest *)request
                            entityCompletitionBlock:(void(^)(NSDictionary *entity))entityCompletitionBlock
                          completitionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completitionHandler {
    NSURLSessionDataTask *singleEntityTask =
        [[self createUrlSession] dataTaskWithRequest:request completionHandler:completitionHandler];
    [singleEntityTask resume];
}

- (void)basicEntitiesOperationWithRequest:(NSURLRequest *)request
                entitiesCompletitionBlock:(void(^)(NSArray *entities))entitiesCompletitionBlock
                      completitionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completitionHandler {
    NSURLSession *session = [self createUrlSession];
    NSURLSessionDataTask *entitiesTask =
        [session dataTaskWithRequest:request completionHandler:completitionHandler];
    [entitiesTask resume];
}

- (void)fetchEntitiesWithEntityPathElements:(NSArray *)pathElements
                          completitionBlock:(void(^)(NSArray *entities))completitionBlock {
    NSURLRequest *request = [self makeGETRequestWithPathElements:pathElements];
    [self basicEntitiesOperationWithRequest:request
                  entitiesCompletitionBlock:completitionBlock
                        completitionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         NSArray *entities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         [self executeCompletitionBlock:completitionBlock object:entities];
     }];
}

- (void)fetchSingleEntityWithEntityPathElements:(NSArray *)pathElements
                              completitionBlock:(void(^)(NSDictionary *entity))completitionBlock {
    NSURLRequest *request = [self makeGETRequestWithPathElements:pathElements];
    [self basicSingleEntityOperationWithRequest:request
                        entityCompletitionBlock:completitionBlock
                            completitionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *entity = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
         [self executeCompletitionBlock:completitionBlock object:entity];
     }];
}

- (void)addEntity:(NSDictionary *)entity
     pathElements:(NSArray *)pathElements
completitionBlock:(void(^)(NSDictionary *entity))completitionBlock {    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:entity
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSURLRequest *request = [self makePOSTRequestWithPathElements:pathElements
                                                         HTTPBody:bodyData];
    [self basicSingleEntityOperationWithRequest:request
                        entityCompletitionBlock:completitionBlock
                            completitionHandler:[self basicHandlerWithCompletitionBlock:completitionBlock
                                                                                 entity:entity]];
}

- (void)updateEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completitionBlock:(void(^)(NSDictionary *entity))completitionBlock {
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:entity
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSURLRequest *request = [self makePUTRequestWithPathElements:pathElements
                                                        HTTPBody:bodyData];
    [self basicSingleEntityOperationWithRequest:request
                        entityCompletitionBlock:completitionBlock
                            completitionHandler:[self basicHandlerWithCompletitionBlock:completitionBlock
                                                                                 entity:entity]];
}

- (void)deleteEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completitionBlock:(void(^)(NSDictionary *entity))completitionBlock {
    NSURLRequest *request = [self makeDELETERequestWithPathElements:pathElements];
    [self basicSingleEntityOperationWithRequest:request
                        entityCompletitionBlock:completitionBlock
                            completitionHandler:[self basicHandlerWithCompletitionBlock:completitionBlock
                                                                                 entity:entity]];
}

@end
