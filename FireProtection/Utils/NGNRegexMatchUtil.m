//
//  NGNRegexMatchUtil.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 23.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNRegexMatchUtil.h"

@implementation NGNRegexMatchUtil

+ (BOOL)isString:(NSString *)string matchToRegex:(NSString *)stringRegex {
    NSError *error = nil;
    NSRange searchedRange = NSMakeRange(0, string.length);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:stringRegex options:0 error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:searchedRange];
    
    if (match){
        return YES;
    }
    return NO;
}

@end
