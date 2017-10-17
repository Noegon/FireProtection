//
//  NGNLocalSubstancePileDetailController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 17.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NGNLocalSubstancePile;
@class NGNSubstance;

@interface NGNLocalSubstancePileDetailController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *pileHeightTextField;
@property (strong, nonatomic) IBOutlet UITextField *pileSquareTextField;
@property (strong, nonatomic) NGNSubstance *storedSubstance;

@property (strong, nonatomic) NGNLocalSubstancePile *substancePile;
@property (unsafe_unretained, nonatomic, getter=isPileAdded) BOOL pileAdded;

@end
