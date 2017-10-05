//
//  NGNFireSafetyCategoryDetailController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNBasicVocabularyController.h"

@class NGNFireSafetyCategory;

@interface NGNFireSafetyCategoryDetailController : NGNBasicVocabularyController

@property (strong, nonatomic) NGNFireSafetyCategory *fireSafetyCategory;

@end
