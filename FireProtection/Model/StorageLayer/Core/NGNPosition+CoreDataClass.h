//
//  NGNPosition+CoreDataClass.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NGNFireResistanceRank, NGNFireSafetyCategory, NGNFunctionalFireSafetyCategory, NGNProject, NGNRoom;

NS_ASSUME_NONNULL_BEGIN

@interface NGNPosition : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "NGNPosition+CoreDataProperties.h"
