//
//  NGNSubstanceTypeDetailController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicVocabularyController.h"

@class NGNSubstanceType;

@interface NGNSubstanceTypeDetailController : NGNBasicVocabularyController

@property (strong, nonatomic) NGNSubstanceType *substanceType;

@end
