//
//  NGNCoreDataEntitiesConstants.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCoreDataEntitiesConstants.h"

@implementation NGNCoreDataEntitiesConstants

+ (NSArray *)vocabularyEntities {
    return @[kNGNModelEntityNameFireResistanceRank,
             kNGNModelEntityNameFireSafetyCategory,
             kNGNModelEntityNameFunctionalFireSafetyCategory,
             kNGNModelEntityNameFunctionalFireSafetySubcategory,
             kNGNModelEntityNameSubstanceType,
             kNGNModelEntityNameMinimumREIConstructionType];
}

+ (NSArray *)nonVocabularyEntities {
    return @[kNGNModelEntityNameUser,
             kNGNModelEntityNameProject,
             kNGNModelEntityNamePosition,
             kNGNModelEntityNameRoom,
             kNGNModelEntityNameApertureGroup,
             kNGNModelEntityNameSubstance,
             kNGNModelEntityNameSubstancePile];
}

@end
