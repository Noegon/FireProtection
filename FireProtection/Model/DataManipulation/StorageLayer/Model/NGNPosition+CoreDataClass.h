//
//  NGNPosition+CoreDataClass.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NGNFireResistanceRank;
@class NGNFireSafetyCategory;
@class NGNFunctionalFireSafetySubcategory;
@class NGNProject;
@class NGNRoom;
@class NGNUser;

NS_ASSUME_NONNULL_BEGIN

@interface NGNPosition : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NGNPosition+CoreDataProperties.h"
