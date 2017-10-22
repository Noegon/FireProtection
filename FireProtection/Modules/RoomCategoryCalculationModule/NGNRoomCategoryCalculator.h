//
//  NGNRoomCategoryCalculator.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 15.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNLocalizationConstants.h"

@class NGNLocalSubstancePile;
@class NGNFireSafetyCategory;
@class NGNRoomCategoryCalculator;

typedef NS_ENUM(NSInteger, NGNRoomWayOfFireLoadStoring) {
    NGNSubstancesInStandardConditions = 0,
    NGNSubstancesUsingAsFuel,
    NGNWarmRadiatingWithoutBurning,
    NGNImplementationOfWetProcess
};

static NSInteger const kNGNnumberOfRoomProcessSemanticTypes = 4;

@protocol NGNRoomCategoryCalculatorDelegate <NSObject>

@optional
- (void)categoryCalculator:(NGNRoomCategoryCalculator * _Nonnull)calculator
didEndCalculationWithCategory:(NGNFireSafetyCategory * _Nullable)category
          specificFireLoad:(double)specificFireLoad
           overallFireLoad:(double)overallFireLoad;

@end

@interface NGNRoomCategoryCalculator: NSObject

@property (nonatomic, weak) _Nullable id <NGNRoomCategoryCalculatorDelegate> delegate;

#pragma mark - Fire hazard calculation methods
//To get result - implement delegate method in current class
- (void)calculateFireHazardWithSubtancePiles:(NSArray<NGNLocalSubstancePile *> * _Nonnull)substancePiles
                                  roomHeight:(double)roomHeight
                       floorProjectionSquare:(double)floorProjectionSquare
                             roomProcessType:(NGNRoomWayOfFireLoadStoring)roomProcessType;
#pragma mark - helper methods
    
- (NSString * _Nonnull)stringRoomProcessSemanticType:(NGNRoomWayOfFireLoadStoring)roomWayOfFireLoadStoring;

@end
