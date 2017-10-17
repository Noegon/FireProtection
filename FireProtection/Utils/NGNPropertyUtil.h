//
//  NGNPropertyUtil.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNPropertyUtil : NSObject

+ (NSDictionary *)propertiesOfObject:(id)object;
+ (NSDictionary *)propertiesOfClass:(Class)klass;
+ (NSDictionary *)propertiesOfSubclass:(Class)klass;

@end
