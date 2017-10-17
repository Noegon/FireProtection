//
//  NGNRoom+CoreDataClass.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NGNApertureGroup;
@class NGNFireSafetyCategory;
@class NGNMinimumREIConstructionType;
@class NGNPosition;
@class NGNSubstancePile;
@class NGNUser;

NS_ASSUME_NONNULL_BEGIN

@interface NGNRoom : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NGNRoom+CoreDataProperties.h"
