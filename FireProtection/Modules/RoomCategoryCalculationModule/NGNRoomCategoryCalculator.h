//
//  NGNRoomCategoryCalculator.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 15.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNLocalSubstancePile;
@class NGNFireSafetyCategory;
@class NGNRoomCategoryCalculator;

typedef NS_ENUM(NSInteger, NGNRoomProcessSemanticTypes) {
    NGNSubstancesInStandardConditions = 0,
    NGNSubstancesUsingAsFuel,
    NGNWarmRadiatingWithoutBurning,
    NGNImplementationOfWetProcess
};

static NSInteger const kNGNnumberOfRoomProcessSemanticTypes = 4;

static NSString * const NGNStringRoomProcessSemanticType[] = {
    [NGNSubstancesInStandardConditions] = @"Standard substance storing",
    [NGNSubstancesUsingAsFuel] = @"Substance using as fuel",
    [NGNWarmRadiatingWithoutBurning] = @"Radiating warm without fire",
    [NGNImplementationOfWetProcess] = @"Wet processes in room"
};

@protocol NGNRoomCategoryCalculatorDelegate <NSObject>

@optional
- (void)categoryCalculator:(NGNRoomCategoryCalculator *)calculator
didEndCalculationWithCategory:(NGNFireSafetyCategory *)category
          specificFireLoad:(double)specificFireLoad
           overallFireLoad:(double)overallFireLoad;

@end

@interface NGNRoomCategoryCalculator: NSObject

@property (nonatomic, weak) id<NGNRoomCategoryCalculatorDelegate> delegate;

//To get result - implement delegate method in current class
- (void)calculateFireHazardWithSubtancePiles:(NSArray<NGNLocalSubstancePile *> *)substancePiles
                                  roomHeight:(double)roomHeight
                       floorProjectionSquare:(double)floorProjectionSquare
                             roomProcessType:(NGNRoomProcessSemanticTypes)roomProcessType;

@end
