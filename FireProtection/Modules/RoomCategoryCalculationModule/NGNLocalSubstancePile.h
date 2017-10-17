//
//  NGNLocalSubstancePile.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 16.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNSubstance;

@interface NGNLocalSubstancePile : NSObject

@property (strong, nonatomic) NGNSubstance *substance;
@property (unsafe_unretained, nonatomic) double pileHeight;
@property (unsafe_unretained, nonatomic) double pileProjectionSquare;

@end
