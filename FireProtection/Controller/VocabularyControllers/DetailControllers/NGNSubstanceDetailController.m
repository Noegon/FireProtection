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
@property (strong, nonatomic) IBOutlet UIPickerView *substanceTypePickerView;

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
    NSUInteger index = [self.substanceTypes indexOfObject:self.substance.substanceType];
    if (self.substance) {
        [self.substanceTypePickerView selectRow:index inComponent:0 animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (IBAction)saveBarButtonTapped:(UIBarButtonItem *)sender {
    NGNSubstanceType *currentSubstanceType =
        self.substanceTypes[[self.substanceTypePickerView selectedRowInComponent:0]];
    if (!self.substance) {
        __weak NGNSubstanceDetailController *weakSelf = self;
        self.substance = [NGNSubstance ngn_createEntityInManagedObjectContext:[NGNDataBaseManager managedObjectContext] fieldscompletionBlock:^(NSManagedObject *substance){
            ((NGNSubstance *)substance).idx = (NSDecimalNumber *)@(foo4random());
            ((NGNSubstance *)substance).name = weakSelf.nameTextField.text;
            ((NGNSubstance *)substance).density = @([weakSelf.densityTextField.text doubleValue]);
            ((NGNSubstance *)substance).requiredAirAmount = @([weakSelf.requiredAirAmountTextField.text doubleValue]);
            ((NGNSubstance *)substance).heatOfCombusion = @([weakSelf.heatOfCombusionTextField.text doubleValue]);
            ((NGNSubstance *)substance).flameSpeed = @([weakSelf.flameSpeedTextField.text doubleValue]);
            ((NGNSubstance *)substance).burningRate = @([weakSelf.burningRateTextField.text doubleValue]);
            
            NSFetchRequest *request = [NGNUser fetchRequest];
            request.predicate = [NSPredicate predicateWithFormat:@"self.idx == %@",
                                 [NGNApplicationStateManager sharedInstance].currentSessionUserId];
            NSError *error = nil;
            NSArray *result = [[NGNDataBaseManager managedObjectContext] executeFetchRequest:request error:&error];
            if (!error && result.count > 0) {
                NGNUser *currentUser = result[0];
                ((NGNSubstance *)substance).user = currentUser;
            } else {
                ((NGNSubstance *)substance).user = nil;
            }
            ((NGNSubstance *)substance).substanceType = currentSubstanceType;
        }];
    }
    if (currentSubstanceType) {
        self.substance.substanceType = currentSubstanceType;
        [NGNDataBaseManager saveContext];
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
//    NGNSubstanceType *currentSubstanceType = self.substanceTypes[row];
    //Temporary nothing happens
}

@end
