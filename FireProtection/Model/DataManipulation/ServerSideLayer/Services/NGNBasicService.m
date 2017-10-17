//
//  NGNBasicService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNBasicService.h"
#import "NGNServerSideLayerConstants.h"
#import "NGNCommonConstants.h"

typedef void (^BasicCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface NGNBasicService ()

@end

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
        if (![stringfiedElement containsString:@"/"] &&
            ![stringfiedElement isEqualToString:resourcePathElements[0]] &&
            ![stringfiedElement isEqualToString:resourcePathElements[resourcePathElements.count - 1]]) {
            [finalPath appendString:@"/"];
        }
    }
    return [NSURL URLWithString:finalPath];
}

- (void)executeCompletionBlock:(void(^)(id object, NSError *error))completionBlock
                        object:(id)object error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^() {
        if (completionBlock) {
            completionBlock(object, error);
        }
    });
}

- (BasicCompletionHandler)basicHandlerWithcompletionBlock:(void(^)(id object, NSError *error))completionBlock
                                                   entity:(id)object {
    return ^void(NSData *data, NSURLResponse *response, NSError *error) {
        [self executeCompletionBlock:completionBlock object:object error:error];
    };
}

- (NSURLRequest *)makeRequestWithPathElements:(NSArray *)pathElements
                                   HTTPMethod:(NSString * _Nullable)HTTPMethod
                                     HTTPBody:(NSData * _Nullable)HTTPBody
                         HTTPHeadersForFields:(NSDictionary * _Nullable)HTTPHeadersForFields {
    NSURL *url = [self makeResourceURLWithServerUrl:kNGNServerURL
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
                                  HTTPMethod:kNGNHTTPMethodGET
                                    HTTPBody:nil
                        HTTPHeadersForFields:nil];
}

- (NSURLRequest *)makePOSTRequestWithPathElements:(NSArray *)pathElements
                                         HTTPBody:(NSData * _Nullable)HTTPBody {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:kNGNHTTPMethodPOST
                                    HTTPBody:HTTPBody
                        HTTPHeadersForFields:@{kNGNHTTPHeaderContentType: kNGNHTTPDataTypeJSON,
                                               kNGNHTTPHeaderAccept: kNGNHTTPDataTypeJSON}];
}

- (NSURLRequest *)makePUTRequestWithPathElements:(NSArray *)pathElements
                                        HTTPBody:(NSData * _Nullable)HTTPBody {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:kNGNHTTPMethodPUT
                                    HTTPBody:HTTPBody
                        HTTPHeadersForFields:@{kNGNHTTPHeaderContentType: kNGNHTTPDataTypeJSON,
                                               kNGNHTTPHeaderAccept: kNGNHTTPDataTypeJSON}];
}

- (NSURLRequest *)makeDELETERequestWithPathElements:(NSArray *)pathElements {
    return [self makeRequestWithPathElements:pathElements
                                  HTTPMethod:kNGNHTTPMethodDELETE
                                    HTTPBody:nil
                        HTTPHeadersForFields:nil];
}

@end

@implementation NGNBasicService(NGNOperationsWithEntities)

- (void)basicSingleEntityOperationWithRequest:(NSURLRequest *)request
                            entitycompletionBlock:(void(^)(NSDictionary *entity, NSError *error))entitycompletionBlock
                          completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSURLSessionDataTask *singleEntityTask =
        [[self createUrlSession] dataTaskWithRequest:request completionHandler:completionHandler];
    [singleEntityTask resume];
}

- (void)basicEntitiesOperationWithRequest:(NSURLRequest *)request
                entitiescompletionBlock:(void(^)(NSArray *entities, NSError *error))entitiescompletionBlock
                      completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSURLSession *session = [self createUrlSession];
    NSURLSessionDataTask *entitiesTask =
        [session dataTaskWithRequest:request completionHandler:completionHandler];
    [entitiesTask resume];
}

- (void)fetchEntitiesWithEntityPathElements:(NSArray *)pathElements
                          completionBlock:(void(^)(NSArray *entities, NSError *error))completionBlock {
    NSURLRequest *request = [self makeGETRequestWithPathElements:pathElements];
    [self basicEntitiesOperationWithRequest:request
                  entitiescompletionBlock:completionBlock
                        completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         NSArray *entities = nil;
         if (!error) {
             entities = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
         }
         [self executeCompletionBlock:completionBlock object:entities error:error];
     }];
}

- (void)fetchSingleEntityWithEntityPathElements:(NSArray *)pathElements
                              completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    NSURLRequest *request = [self makeGETRequestWithPathElements:pathElements];
    [self basicSingleEntityOperationWithRequest:request
                        entitycompletionBlock:completionBlock
                            completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *entity = nil;
         if (!error) {
             entity = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingMutableContainers
                                                        error:&error];
         }
         [self executeCompletionBlock:completionBlock object:entity error:error];
     }];
}

- (void)addEntity:(NSDictionary *)entity
     pathElements:(NSArray *)pathElements
completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:entity
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSURLRequest *request = [self makePOSTRequestWithPathElements:pathElements
                                                         HTTPBody:bodyData];
    [self basicSingleEntityOperationWithRequest:request
                        entitycompletionBlock:completionBlock
                            completionHandler:[self basicHandlerWithcompletionBlock:completionBlock
                                                                                 entity:entity]];
}

- (void)updateEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:entity
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSURLRequest *request = [self makePUTRequestWithPathElements:pathElements
                                                        HTTPBody:bodyData];
    [self basicSingleEntityOperationWithRequest:request
                        entitycompletionBlock:completionBlock
                            completionHandler:[self basicHandlerWithcompletionBlock:completionBlock
                                                                                 entity:entity]];
}

- (void)deleteEntity:(NSDictionary *)entity
        pathElements:(NSArray *)pathElements
   completionBlock:(void(^)(NSDictionary *entity, NSError *error))completionBlock {
    NSURLRequest *request = [self makeDELETERequestWithPathElements:pathElements];
    [self basicSingleEntityOperationWithRequest:request
                        entitycompletionBlock:completionBlock
                            completionHandler:[self basicHandlerWithcompletionBlock:completionBlock
                                                                                 entity:entity]];
}

- (void)deleteEntities:(NSArray * _Nullable)entities
        pathElements:(NSArray *)pathElements
     completionBlock:(void(^)(NSArray * _Nullable entities, NSError *error))completionBlock {
    NSURLRequest *request = [self makeDELETERequestWithPathElements:pathElements];
    [self basicEntitiesOperationWithRequest:request
                      entitiescompletionBlock:completionBlock
                          completionHandler:[self basicHandlerWithcompletionBlock:completionBlock
                                                                           entity:entities]];
}

@end
