//
//  NGNTemporarySubstancePilesController.h
//  FireProtection
//
//  Created by Alexey Stafeyev on 16.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NGNLocalSubstancePile;

@interface NGNTemporarySubstancePilesController : UITableViewController

@property (strong, nonatomic) NSMutableArray<NGNLocalSubstancePile *> *substancePiles;

@end
