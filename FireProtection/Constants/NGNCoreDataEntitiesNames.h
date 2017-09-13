//
//  NGNCoreDataEntitiesNames.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 22.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//
#import <Foundation/Foundation.h>

static NSString *const kNGNModelEntityNameUser = @"NGNUser";
static NSString *const kNGNModelEntityNameProject = @"NGNProject";
static NSString *const kNGNModelEntityNamePosition = @"NGNPosition";
static NSString *const kNGNModelEntityNameRoom = @"NGNRoom";
static NSString *const kNGNModelEntityNameApertureGroup = @"NGNApertureGroup";
static NSString *const kNGNModelEntityNameSubstance = @"NGNSubstance";
static NSString *const kNGNModelEntityNameSubstancePile = @"NGNSubstancePile";
static NSString *const kNGNModelEntityNameFireResistanceRank = @"NGNFireResistanceRank";
static NSString *const kNGNModelEntityNameFireSafetyCategory = @"NGNFireSafetyCategory";
static NSString *const kNGNModelEntityNameFunctionalFireSafetyCategory = @"NGNFunctionalFireSafetyCategory";
static NSString *const kNGNModelEntityNameFunctionalFireSafetySubcategory = @"NGNFunctionalFireSafetySubcategory";
static NSString *const kNGNModelEntityNameSubstanceType = @"NGNSubstanceType";
static NSString *const kNGNModelEntityNameMinimumREIConstructionType = @"NGNMinimumREIConstructionType";

@interface NGNCoreDataEntitiesNames : NSObject

@property (class, strong, nonatomic, readonly) NSArray *vocabularyEntities;

@end
