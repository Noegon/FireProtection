//
//  NGNManagedObjectMappingProtocol.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 10.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastEasyMapping/FastEasyMapping.h>

@protocol NGNManagedObjectMappingProtocol <NSObject>

+ (FEMMapping *)defaultMapping;

@end
