//
//  NGNSubstancePile+CoreDataProperties.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 08.09.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//
//

#import "NGNSubstancePile+CoreDataProperties.h"

@implementation NGNSubstancePile (CoreDataProperties)

+ (NSFetchRequest<NGNSubstancePile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNSubstancePile"];
}

- (NSNumber *)mass {
    double result = self.projectionSquare.doubleValue * self.mediumPileHeight.doubleValue;
    return @(result);
}

@dynamic idx;
@dynamic projectionSquare;
@dynamic mediumPileHeight;
@dynamic maxPileHeight;
@dynamic room;
@dynamic substance;

@end
