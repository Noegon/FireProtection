//
//  NGNCoreDataEntitiesNames.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCoreDataEntitiesNames.h"

@implementation NGNCoreDataEntitiesNames

+ (NSArray *)vocabularyEntities {
    return @[kNGNModelEntityNameFireResistanceRank,
             kNGNModelEntityNameFireSafetyCategory,
             kNGNModelEntityNameFunctionalFireSafetyCategory,
             kNGNModelEntityNameFunctionalFireSafetySubcategory,
             kNGNModelEntityNameSubstanceType,
             kNGNModelEntityNameMinimumREIConstructionType];
}

@end
