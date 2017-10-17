//
//  NGNRegexMatchUtil.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNRegexMatchUtil : NSObject

+ (BOOL)isString:(NSString *)string matchToRegex:(NSString *)stringRegex;

@end
