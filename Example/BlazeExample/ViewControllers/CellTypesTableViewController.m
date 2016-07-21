//
//  CellTypesTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "CellTypesTableViewController.h"

@interface CellTypesTableViewController ()
{
    
}

@property(nonatomic,strong) NSDate *date;

@property(nonatomic,strong) NSNumber *switchValue;
@property(nonatomic,strong) NSNumber *sliderValue;
@property(nonatomic,strong) NSNumber *checkBoxValue;
@property(nonatomic,strong) NSNumber *twoChoicesValue;
@property(nonatomic,strong) NSNumber *segmentedControlValue;

@property(nonatomic,strong) NSString *pickerValue;
@property(nonatomic,strong) NSString *textfieldValue;

@end

@implementation CellTypesTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load table
    [self loadTable];
}

-(void)loadTable
{    
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    //Textfield
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Now an awesome float-label textfield - check automatic prev/next buttons."];
    [self addSection:section];
    
    //Textfield
    row = [[BlazeRow alloc] initWithXibName:kFloatTextFieldTableViewCell rowType:BlazeRowTextField];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(textfieldValue)]];
    row.placeholder = @"Float title placeholder";
    [row setValueChanged:^{
        DLog(@"Use this when you want something done as soon as the value changes. This also log is also proving it automatically updates the value of the set affected object: %@", self.textfieldValue);
    }];
    [section addRow:row];
    
    //Date & Picker
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Dates and pickerviews"];
    [self addSection:section];
    
    //Date
    row = [[BlazeRow alloc] initWithXibName:kDateFieldTableViewCell rowType:BlazeRowDate title:@"Datefield"];
    row.placeholder = @"Date placeholder";
    row.dateMinuteInterval = 5;
    row.datePickerMode = UIDatePickerModeDateAndTime;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"d MMMM yyyy"];
    row.dateFormatter = df;
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(date)]];
    [section addRow:row];
    
    //Picker
    row = [[BlazeRow alloc] initWithXibName:kPickerFieldTableViewCell rowType:BlazeRowPicker title:@"Pickerfield"];
    row.placeholder = NSLocalizedString(@"Picker placeholder", @"");
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(pickerValue)]];
    row.selectorOptions = @[@"Automatic next/previous", @"buttons always work", @"Doesn't matter if you", @"use textfields", @"or datepickers", @"or pickerviews", @"or multiple sections"];
    [section addRow:row];
    
    //Button
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Button with completion block"];
    [self addSection:section];
    
    //Button
    row = [[BlazeRow alloc] initWithXibName:kButtonTableViewCell rowType:BlazeRowBasic];
    row.buttonCenterTitle = @"Title can be attributed";
    [row setButtonCenterTapped:^{
        showM1(@"Button tapped!");
    }];
    [section addRow:row];
    
    //Slider
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Slider"];
    [self addSection:section];
    
    //Slider
    self.sliderValue = @(7);
    row = [[BlazeRow alloc] initWithXibName:kSliderTableViewCell rowType:BlazeRowSlider];
    row.sliderMin = 0;
    row.sliderMax = 17;
    row.sliderLeftText = @"Min";
    row.sliderRightText = @"Max";
    row.sliderCenterText = @"Awesomeness scale";
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(sliderValue)]];
    [row setValueChanged:^{
        DLog(@"Slider changed: %.1f", [self.sliderValue floatValue]);
    }];
    [section addRow:row];
    
    //Slider
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Switch/checkbox/two choices"];
    [self addSection:section];
    
    //Switch
    row = [[BlazeRow alloc] initWithXibName:kSwitchTableViewCell rowType:BlazeRowSwitch title:@"Switcheroo"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(switchValue)]];
    [row setValueChanged:^{
        DLog(@"Switch changed: %@", [self.switchValue boolValue] ? @"ON" : @"OFF");
    }];
    [section addRow:row];
    
    //Checkbox
    row = [[BlazeRow alloc] initWithXibName:kCheckboxTableViewCell rowType:BlazeRowCheckbox title:@"Checkycheck"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(checkBoxValue)]];
    row.checkboxImageActive = @"Checkbox_Active";
    row.checkboxImageInactive = @"Checkbox_Inactive";
    [row setValueChanged:^{
        DLog(@"Checkbox changed: %@", [self.checkBoxValue boolValue] ? @"ON" : @"OFF");
    }];
    [section addRow:row];
    
    //Two choices
    row = [[BlazeRow alloc] initWithXibName:kTwoChoicesTableViewCell rowType:BlazeRowCheckbox title:@"Two choices"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(twoChoicesValue)]];
    row.checkboxImageActive = @"Checkbox_Active";
    row.checkboxImageInactive = @"Checkbox_Inactive";
    [row setValueChanged:^{
        DLog(@"Two choices changed: %d", [self.twoChoicesValue intValue]);
    }];
    [section addRow:row];
    
    //Slider
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Segmented control"];
    [self addSection:section];
    
    //SegmentedControl
    row = [[BlazeRow alloc] initWithXibName:kSegmentedControlTableViewCell rowType:BlazeRowSegmentedControl title:@"Segmented control"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(segmentedControlValue)]];
    row.selectorOptions = @[@"This control", @"Is dynamically", @"Filled"];
    [row setValueChanged:^{
        DLog(@"Segment changed: %d", [self.segmentedControlValue intValue]);
    }];
    [section addRow:row];
    
    //Image
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Let's finish with an image!"];
    [self addSection:section];
    
    //SegmentedControl
    row = [[BlazeRow alloc] initWithXibName:kImageTableViewCell];
    row.imageNameCenter = @"Blaze_Logo";
    [section addRow:row];
    
    //Some empty space looks better
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
}

@end









































