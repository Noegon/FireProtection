//
//  NGNRoomCategoryCalculator.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 15.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNRoomCategoryCalculator.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNLocalSubstancePile.h"

NSUInteger const kNGNMinimalRoomSquare = 10; //sq_meters
NSUInteger const kNGNMaximumRoomAirTemperature = 61; //celsium_degrees

@implementation NGNRoomCategoryCalculator

#pragma mark - Explosion hazard calculation methods

- (BOOL)calculateExplosionHasardWithSubstance:(NGNSubstance *)substance mass:(NSUInteger)mass {
    return YES;
}

#pragma mark - Fire hazard calculation methods

- (void)calculateFireHazardWithSubtancePiles:(NSArray<NGNLocalSubstancePile *> *)substancePiles
                                                               roomHeight:(double)roomHeight
                                                    floorProjectionSquare:(double)floorProjectionSquare
                                                          roomProcessType:(NGNRoomWayOfFireLoadStoring)roomProcessType {

    NSMutableArray *substances = [NSMutableArray new];
    NSMutableArray *pilesHeights = [NSMutableArray new];
    NSMutableArray *pilesProjectionSquares = [NSMutableArray new];
    
    for (NGNLocalSubstancePile *pile in substancePiles) {
        [substances addObject:pile.substance];
        [pilesHeights addObject:@(pile.pileHeight)];
        [pilesProjectionSquares addObject:@(pile.pileProjectionSquare)];
    }
    
    [self calculateFireHazardWithSubtances:substances
                              pilesHeights:pilesHeights
                    pilesProjectionSquares:pilesProjectionSquares
                                roomHeight:roomHeight
                     floorProjectionSquare:floorProjectionSquare
                           roomProcessType:roomProcessType];
}

//alternative descision without additional entities
- (void)calculateFireHazardWithSubtances:(NSArray<NGNSubstance *> *)substances
                            pilesHeights:(NSArray<NSNumber *> *)pilesHeights
                  pilesProjectionSquares:(NSArray<NSNumber *> *)pilesProjectionSquares
                              roomHeight:(NSUInteger)roomHeight
                   floorProjectionSquare:(NSUInteger)floorProjectionSquare
                         roomProcessType:(NGNRoomWayOfFireLoadStoring)roomProcessType {
    
    if (floorProjectionSquare < kNGNMinimalRoomSquare) {
        floorProjectionSquare = kNGNMinimalRoomSquare;
    }
    
    NGNFireSafetyCategory *fireSafetyCategory = nil;
    double specificTemporaryFireLoad = 0;
    double overallFireLoad = 0;
    double overAllPilesVolume = 0;
    
    NSFetchRequest *request = [NGNFireSafetyCategory fetchRequest];
    
    NSError *error = nil;
    NSArray *validCategories = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request
                                                                                        error:&error];
    if (!error) {
        
        if (roomProcessType == NGNSubstancesUsingAsFuel ||
            roomProcessType == NGNWarmRadiatingWithoutBurning ||
            roomProcessType == NGNImplementationOfWetProcess) {
            NSString *category = nil;
            switch (roomProcessType) {
                case NGNSubstancesInStandardConditions:
                    break;
                case NGNSubstancesUsingAsFuel:
                    category = [NSString stringWithUTF8String:"Г1"];
                    break;
                case NGNWarmRadiatingWithoutBurning:
                    category = [NSString stringWithUTF8String:"Г2"];
                    break;
                case NGNImplementationOfWetProcess:
                    category = [NSString stringWithUTF8String:"Д"];
                    break;
            }
            fireSafetyCategory = [validCategories filteredArrayUsingPredicate:
                                  [NSPredicate predicateWithFormat:@"self.name == %@", category]][0];
        }
        
        if (!fireSafetyCategory) {
            
            NSInteger index = 0;
            for (NGNSubstance *substance in substances) {
                overAllPilesVolume += pilesHeights[index].doubleValue * pilesProjectionSquares[index].doubleValue;
                
                overallFireLoad += (substance.heatOfCombusion.doubleValue *
                                    pilesHeights[index].doubleValue *
                                    substance.density.doubleValue *
                                    pilesProjectionSquares[index].doubleValue);
                index += 1;
            }
            
            //Check if room volume less than fire load materials volume
            if ((roomHeight * floorProjectionSquare) > overAllPilesVolume) {
                specificTemporaryFireLoad = overallFireLoad / floorProjectionSquare;
                
                NSPredicate *predicate =
                [NSPredicate predicateWithBlock:
                 ^BOOL(NGNFireSafetyCategory *fireSafetyCategory, NSDictionary<NSString *,id> * _Nullable bindings) {
                     return (fireSafetyCategory.minimumSpecificFireLoad.integerValue != 0 &&
                             fireSafetyCategory.maximumSpecificFireLoad.integerValue != 0 &&
                             fireSafetyCategory.minimumSpecificFireLoad.integerValue <= specificTemporaryFireLoad &&
                             fireSafetyCategory.maximumSpecificFireLoad.integerValue >= specificTemporaryFireLoad);
                 }];
                
                NSArray *result = [validCategories filteredArrayUsingPredicate:predicate];
                
                if (result.count != 0) {
                    fireSafetyCategory = [validCategories filteredArrayUsingPredicate:predicate][0];
                } else {
                    NSString *category = [NSString stringWithUTF8String:"Д"];
                    fireSafetyCategory = [validCategories filteredArrayUsingPredicate:
                                          [NSPredicate predicateWithFormat:@"self.name == %@", category]][0];
                }
                
                NSUInteger gtCoefficient = 0;
                NSString *finalCategoryName = @"";
                if ([fireSafetyCategory.name isEqualToString:@"В2"] ||
                    [fireSafetyCategory.name isEqualToString:@"В3"]) {
                    
                    double finalSpecificTemporaryFireLoad = 0;
                    
                    if ([fireSafetyCategory.name isEqualToString:@"В2"]) {
                        gtCoefficient = 2200;
                        finalSpecificTemporaryFireLoad = 0.64 * gtCoefficient * pow(roomHeight, 2);
                        if (specificTemporaryFireLoad >= finalSpecificTemporaryFireLoad) {
                            finalCategoryName = @"В1";
                        }
                    } else {
                        gtCoefficient = 1400;
                        finalSpecificTemporaryFireLoad = 0.64 * gtCoefficient * pow(roomHeight, 2);
                        if (specificTemporaryFireLoad >= finalSpecificTemporaryFireLoad) {
                            finalCategoryName = @"В2";
                        }
                    }
                    
                    if (![finalCategoryName isEqualToString:@""]) {
                        NGNFireSafetyCategory *secondIterationCategory =
                        [validCategories filteredArrayUsingPredicate:
                         [NSPredicate predicateWithFormat:@"self.name == %@", finalCategoryName]][0];
                        fireSafetyCategory = secondIterationCategory;
                    }
                }
            }
        }
    }
    
    [self.delegate categoryCalculator:self
        didEndCalculationWithCategory:fireSafetyCategory
                     specificFireLoad:specificTemporaryFireLoad
                      overallFireLoad:overallFireLoad];
}
    
#pragma mark - helper methods
    
- (NSString *)stringRoomProcessSemanticType:(NGNRoomWayOfFireLoadStoring)roomWayOfFireLoadStoring {
    switch (roomWayOfFireLoadStoring) {
        case NGNSubstancesInStandardConditions:
        return NSLocalizedString(kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringStandard, nil);
        case NGNSubstancesUsingAsFuel:
        return NSLocalizedString(kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringFuel, nil);
        case NGNWarmRadiatingWithoutBurning:
        return NSLocalizedString(kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringRadiatingWarmNoFire, nil);
        case NGNImplementationOfWetProcess:
        return NSLocalizedString(kNGNLocalizationKeyModelCalculationsFireResistanceRancSubstanceStoringWetProcess, nil);
    }
}

@end
