//
//  NGNSubstanceDetailController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 06.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNSubstanceDetailController.h"
#import "NGNCoreDataModel.h"
#import "NGNDataBaseManager.h"
#import "NGNApplicationStateManager.h"
#import "NSManagedObject+NGNCRUDAppendix.h"

#import "NGNCommonConstants.h"

@interface NGNSubstanceDetailController ()


@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

#pragma mark - main bean properties
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *densityTextField;
@property (strong, nonatomic) IBOutlet UITextField *requiredAirAmountTextField;
@property (strong, nonatomic) IBOutlet UITextField *heatOfCombusionTextField;
@property (strong, nonatomic) IBOutlet UITextField *flameSpeedTextField;
@property (strong, nonatomic) IBOutlet UITextField *burningRateTextField;
@property (strong, nonatomic) IBOutlet UITextField *criticalRadiationDensityTextField;
@property (strong, nonatomic) IBOutlet UITextField *molecularWeightTextField;
@property (strong, nonatomic) IBOutlet UITextField *splashPointTextField;
@property (strong, nonatomic) IBOutlet UITextField *carbonAthomsTextField;
@property (strong, nonatomic) IBOutlet UITextField *oxygenAthomsTextField;
@property (strong, nonatomic) IBOutlet UITextField *hydrogenAthomsTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *substanceTypePickerView;
@property (strong, nonatomic) IBOutlet UITextField *galoidAthomsTextField;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *editableViewsArray;

#pragma mark - helper properties
@property (strong, nonatomic) NSArray *substanceTypes;

- (IBAction)saveBarButtonTapped:(UIBarButtonItem *)sender;


@end

@implementation NGNSubstanceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL isEditable = !self.substance ||
    ([NGNApplicationStateManager sharedInstance].isUserAuthorized &&
    [NGNApplicationStateManager sharedInstance].currentSessionUserId.integerValue == self.substance.user.idx.integerValue);
    
    if (self.substance) {
        self.nameTextField.text = self.substance.name;
        self.densityTextField.text = self.substance.density.stringValue;
        self.requiredAirAmountTextField.text = self.substance.requiredAirAmount.stringValue;
        self.heatOfCombusionTextField.text = self.substance.heatOfCombusion.stringValue;
        self.flameSpeedTextField.text = self.substance.flameSpeed.stringValue;
        self.burningRateTextField.text = self.substance.burningRate.stringValue;
        self.criticalRadiationDensityTextField.text = self.substance.criticalRadiationDensity.stringValue;
        self.molecularWeightTextField.text = self.substance.molecularWeight.stringValue;
        self.splashPointTextField.text = self.substance.splashPoint.stringValue;
        self.carbonAthomsTextField.text = self.substance.carbonAthoms.stringValue;
        self.oxygenAthomsTextField.text = self.substance.oxygenAthoms.stringValue;
        self.hydrogenAthomsTextField.text = self.substance.hydrogenAthoms.stringValue;
        self.galoidAthomsTextField.text = self.substance.galoidsAthoms.stringValue;
    } else {
        for (UITextField *textField in self.editableViewsArray) {
            textField.text = @"";
        }
    }
    
    NSFetchRequest *request = [NGNSubstanceType fetchRequest];
    NSError *error = nil;
    self.substanceTypes = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        self.substanceTypes = @[];
        NSLog(@"Substance types wasn't loaded from local store! Error occured: \n%@", error.userInfo);
    } else {
        NSArray *sortedArray;
        sortedArray = [self.substanceTypes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber *idx1 = [(NGNSubstanceType *)obj1 idx];
            NSNumber *idx2 = [(NGNSubstanceType *)obj2 idx];
            return [idx1 compare:idx2];
        }];
        self.substanceTypes = sortedArray;
    }
    
    if (!isEditable) {
        for (UIView *view in self.editableViewsArray) {
            view.userInteractionEnabled = NO;
        }
        self.saveBarButton.enabled = NO;
        self.substanceTypePickerView.userInteractionEnabled = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUInteger index = [self.substanceTypes indexOfObject:self.substance.substanceType];
    if (self.substance) {
        [self.substanceTypePickerView selectRow:index inComponent:0 animated:YES];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger selectedIndex = [self.substanceTypePickerView selectedRowInComponent:0];
    if (selectedIndex == 0 || selectedIndex == 1 || selectedIndex == 2) {
        return 13;
    }
    return 7;
}

- (IBAction)saveBarButtonTapped:(UIBarButtonItem *)sender {
    NGNSubstanceType *currentSubstanceType =
        self.substanceTypes[[self.substanceTypePickerView selectedRowInComponent:0]];
    if (!self.substance) {
        __weak NGNSubstanceDetailController *weakSelf = self;
        self.substance =
            [NGNSubstance ngn_createEntityInManagedObjectContext:[NGNDataBaseManager managedObjectContext]
                                           fieldscompletionBlock:
             ^(NSManagedObject *substance) {
                 NGNSubstance *currentSubstance = (NGNSubstance *)substance;
                 currentSubstance.idx = (NSDecimalNumber *)@(foo4random());
                 currentSubstance.name = weakSelf.nameTextField.text;
                 currentSubstance.density = @([weakSelf.densityTextField.text doubleValue]);
                 currentSubstance.requiredAirAmount = @([weakSelf.requiredAirAmountTextField.text doubleValue]);
                 currentSubstance.heatOfCombusion = @([weakSelf.heatOfCombusionTextField.text doubleValue]);
                 currentSubstance.criticalRadiationDensity = @([weakSelf.criticalRadiationDensityTextField.text doubleValue]);
                 currentSubstance.flameSpeed = @([weakSelf.flameSpeedTextField.text doubleValue]);
                 currentSubstance.burningRate = @([weakSelf.burningRateTextField.text doubleValue]);
                 currentSubstance.substanceType = currentSubstanceType;
                 currentSubstance.molecularWeight = @([weakSelf.molecularWeightTextField.text doubleValue]);
                 currentSubstance.splashPoint = @([weakSelf.splashPointTextField.text doubleValue]);
                 currentSubstance.carbonAthoms = @([weakSelf.carbonAthomsTextField.text integerValue]);
                 currentSubstance.oxygenAthoms = @([weakSelf.oxygenAthomsTextField.text integerValue]);
                 currentSubstance.hydrogenAthoms = @([weakSelf.hydrogenAthomsTextField.text integerValue]);
                 currentSubstance.galoidsAthoms = @([weakSelf.galoidAthomsTextField.text integerValue]);
                 NSFetchRequest *request = [NGNUser fetchRequest];
                 request.predicate = [NSPredicate predicateWithFormat:@"self.idx == %@",
                                      [NGNApplicationStateManager sharedInstance].currentSessionUserId];
                 NSError *error = nil;
                 NSArray *result = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request error:&error];
                 if (!error && result.count > 0) {
                     NGNUser *currentUser = result[0];
                     currentSubstance.user = currentUser;
                 } else {
                     currentSubstance.user = nil;
                 }
                 [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        if (currentSubstanceType) {
            self.substance.name = self.nameTextField.text;
            self.substance.density = @([self.densityTextField.text doubleValue]);
            self.substance.requiredAirAmount = @([self.requiredAirAmountTextField.text doubleValue]);
            self.substance.heatOfCombusion = @([self.heatOfCombusionTextField.text doubleValue]);
            self.substance.criticalRadiationDensity = @([self.criticalRadiationDensityTextField.text doubleValue]);
            self.substance.flameSpeed = @([self.flameSpeedTextField.text doubleValue]);
            self.substance.burningRate = @([self.burningRateTextField.text doubleValue]);
            self.substance.substanceType = currentSubstanceType;
            self.substance.molecularWeight = @([self.molecularWeightTextField.text doubleValue]);
            self.substance.splashPoint = @([self.splashPointTextField.text doubleValue]);
            self.substance.carbonAthoms = @([self.carbonAthomsTextField.text integerValue]);
            self.substance.oxygenAthoms = @([self.oxygenAthomsTextField.text integerValue]);
            self.substance.hydrogenAthoms = @([self.hydrogenAthomsTextField.text integerValue]);
            self.substance.galoidsAthoms = @([self.galoidAthomsTextField.text integerValue]);
            [NGNDataBaseManager saveContext];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return self.substanceTypes.count;
}

#pragma mark - picker view delegate

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NGNSubstanceType *currentSubstanceType = self.substanceTypes[row];
    return [NSString stringWithFormat:@"%@", currentSubstanceType.name];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (row != 0 && row != 1 && row != 2) {
        self.molecularWeightTextField.text = @(0).stringValue;
        self.splashPointTextField.text = @(-273).stringValue;
        self.carbonAthomsTextField.text = @(0).stringValue;
        self.oxygenAthomsTextField.text = @(0).stringValue;
        self.hydrogenAthomsTextField.text = @(0).stringValue;
        self.galoidAthomsTextField.text = @(0).stringValue;
    }
    
    [self.tableView reloadData];
}

@end
