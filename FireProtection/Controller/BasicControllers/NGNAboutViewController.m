//
//  NGNAboutViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 05.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNAboutViewController.h"
#import "NGNApplicationStateManager.h"
#import "NGNLocalizationConstants.h"

@interface NGNAboutViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation NGNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoTextView.text = NSLocalizedString(kNGNLocalizationKeyUITextAbout, nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([NGNApplicationStateManager sharedInstance].isUserAuthorized) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
}

@end
