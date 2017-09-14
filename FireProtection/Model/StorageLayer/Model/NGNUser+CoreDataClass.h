//
//  NGNUser+CoreDataClass.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NGNProject;
@class NGNPosition;
@class NGNRoom;
@class NGNApertureGroup;
@class NGNSubstance;
@class NGNSubstancePile;

NS_ASSUME_NONNULL_BEGIN

@interface NGNUser : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NGNUser+CoreDataProperties.h"
