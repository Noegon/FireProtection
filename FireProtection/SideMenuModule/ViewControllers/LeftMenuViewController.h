//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Alexey Stafeyev on 04.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
