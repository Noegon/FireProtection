//
//  NGNProject+CoreDataClass.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NGNPosition, NGNUser;

NS_ASSUME_NONNULL_BEGIN

@interface NGNProject : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NGNProject+CoreDataProperties.h"
