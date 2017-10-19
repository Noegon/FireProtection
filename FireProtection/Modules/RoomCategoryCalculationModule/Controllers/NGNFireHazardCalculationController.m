//
//  NGNFireHazardCalculationController.m
//  FireProtection
//
//  Created by Alexey Stafeyev on 16.10.17.
//  Copyright © 2017 Alexey Stafeyev. All rights reserved.
//

#import "NGNFireHazardCalculationController.h"
#import "NGNRoomCategoryCalculator.h"
#import "NGNCoreDataModel.h"
#import "NGNTemporarySubstancePilesController.h"
#import "NGNStoryboardConstants.h"

@interface NGNFireHazardCalculationController () <UIPickerViewDelegate, UIPickerViewDataSource, NGNRoomCategoryCalculatorDelegate>

@property (strong, nonatomic) NGNRoomCategoryCalculator *categoryCalculator;

@property (strong, nonatomic) NSMutableArray<NGNLocalSubstancePile *> *substancePiles;

@property (strong, nonatomic) IBOutlet UITextField *roomNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *roomSquareTextField;
@property (strong, nonatomic) IBOutlet UITextField *roomHeightTextField;
@property (strong, nonatomic) IBOutlet UILabel *placedSubstancePilesTextLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *roomSemanticTypePickerView;
@property (strong, nonatomic) IBOutlet UILabel *specificFireLoadResultTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *overallFireLoadResultTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryResultTextLabel;

- (IBAction)roomSquareDidChanged:(UITextField *)sender;
- (IBAction)roomHeightValueDidChanged:(UITextField *)sender;

@end

@implementation NGNFireHazardCalculationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.substancePiles = [[NSMutableArray alloc] init];
    self.categoryCalculator = [[NGNRoomCategoryCalculator alloc] init];
    self.categoryCalculator.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    return 3;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *controller =  [segue destinationViewController];
    if ([controller isKindOfClass:NGNTemporarySubstancePilesController.class]) {
        ((NGNTemporarySubstancePilesController *)controller).substancePiles = self.substancePiles;
    }
}

- (IBAction)unwindToFireHazardCalculationController:(UIStoryboardSegue *)segue {
    if ([segue.identifier isEqualToString:kNGNStoryboardUnwindSeguePilesToFIreHazardCalculation]) {
        NGNTemporarySubstancePilesController *srcController = segue.sourceViewController;
        self.placedSubstancePilesTextLabel.text = @(srcController.substancePiles.count).stringValue;
        self.substancePiles = srcController.substancePiles;
        [self performCalculation];
    }
}

#pragma mark - basic logic methods

- (IBAction)roomSquareDidChanged:(UITextField *)sender {
    [self performCalculation];
}

- (IBAction)roomHeightValueDidChanged:(UITextField *)sender {
    [self performCalculation];
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return kNGNnumberOfRoomProcessSemanticTypes;
}

#pragma mark - picker view delegate

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.categoryCalculator stringRoomProcessSemanticType:row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    [self performCalculation];
}

#pragma mark - room category calculator delegate
//Helper method to perform calculation
- (void)performCalculation {
    [self.categoryCalculator calculateFireHazardWithSubtancePiles:self.substancePiles
                                                       roomHeight:self.roomHeightTextField.text.doubleValue
                                            floorProjectionSquare:self.roomSquareTextField.text.doubleValue
                                                  roomProcessType:[self.roomSemanticTypePickerView selectedRowInComponent:0]];
}

- (void)categoryCalculator:(NGNRoomCategoryCalculator *)calculator
didEndCalculationWithCategory:(NGNFireSafetyCategory *)category
          specificFireLoad:(double)specificFireLoad
           overallFireLoad:(double)overallFireLoad {
    self.specificFireLoadResultTextLabel.text = [NSString stringWithFormat:@"%.2f", specificFireLoad];
    self.overallFireLoadResultTextLabel.text = [NSString stringWithFormat:@"%.2f", overallFireLoad];;
    self.categoryResultTextLabel.text = category.name;
}

@end
