//
//  NGNSubstanceDetailController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicVocabularyController.h"

@class NGNSubstance;

@interface NGNSubstanceDetailController : NGNBasicVocabularyController

@property (strong, nonatomic) NGNSubstance *substance;

@end
