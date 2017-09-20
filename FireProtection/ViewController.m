//
//  ViewController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 13.08.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "ViewController.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNCommonConstants.h"

@interface ViewController ()

@property (strong, nonatomic) NSNotification *dataLoadedNotification;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(testDataDidLoad)
                                                 name:kNGNApplicationNotificationDataWasLoadedStatus
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)testDataDidLoad {
    NSManagedObjectContext *context = [NGNDataBaseManager managedObjectContext];
    NSError *error = nil;
    NSArray<NGNRoom *> *rooms = [context executeFetchRequest:[NGNRoom fetchRequest] error:&error];
    NSArray<NGNUser *> *users = [context executeFetchRequest:[NGNUser fetchRequest] error:&error];
}

@end
