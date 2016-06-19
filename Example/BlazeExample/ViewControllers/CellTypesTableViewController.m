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
    BlazeTableRow *row;
    BlazeTableSection *section;
    
    //Textfield
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Now an awesome float-label textfield - check automatic prev/next buttons."];
    [self addSection:section];
    
    //Textfield
    row = [[BlazeTableRow alloc] initWithXibName:kFloatTextFieldTableViewCell rowType:BlazeRowTextField];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(textfieldValue)]];
    row.placeholder = @"Float title placeholder";
    [row setValueChanged:^{
        DLog(@"Use this when you want something done as soon as the value changes. This also log is also proving it automatically updates the value of the set affected object: %@", self.textfieldValue);
    }];
    [section addRow:row];
    
    //Date & Picker
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Dates and pickerviews"];
    [self addSection:section];
    
    //Date
    row = [[BlazeTableRow alloc] initWithXibName:kDateFieldTableViewCell rowType:BlazeRowDate title:@"Datefield"];
    row.placeholder = @"Date placeholder";
    row.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"d MMMM yyyy"];
    row.dateFormatter = df;
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(date)]];
    [section addRow:row];
    
    //Picker
    row = [[BlazeTableRow alloc] initWithXibName:kPickerFieldTableViewCell rowType:BlazeRowPicker title:@"Pickerfield"];
    row.placeholder = NSLocalizedString(@"Picker placeholder", @"");
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(pickerValue)]];
    row.selectorOptions = @[@"Automatic next/previous", @"buttons always work", @"Doesn't matter if you", @"use textfields", @"or datepickers", @"or pickerviews", @"or multiple sections"];
    [section addRow:row];
    
    //Button
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Button with completion block"];
    [self addSection:section];
    
    //Button
    row = [[BlazeTableRow alloc] initWithXibName:kButtonTableViewCell rowType:BlazeRowBasic];
    row.buttonCenterTitle = @"Title can be attributed";
    [row setButtonCenterTapped:^{
        showM1(@"Button tapped!");
    }];
    [section addRow:row];
    
    //Slider
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Slider"];
    [self addSection:section];
    
    //Slider
    self.sliderValue = @(7);
    row = [[BlazeTableRow alloc] initWithXibName:kSliderTableViewCell rowType:BlazeRowSlider];
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
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Switch"];
    [self addSection:section];
    
    //Switch
    row = [[BlazeTableRow alloc] initWithXibName:kSwitchTableViewCell rowType:BlazeRowSwitch title:@"Switcheroo"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(switchValue)]];
    [row setValueChanged:^{
        DLog(@"Switch changed: %@", [self.switchValue boolValue] ? @"ON" : @"OFF");
    }];
    [section addRow:row];
    
    //Slider
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Segmented control"];
    [self addSection:section];
    
    //SegmentedControl
    row = [[BlazeTableRow alloc] initWithXibName:kSegmentedControlTableViewCell rowType:BlazeRowSegmentedControl title:@"Segmented control"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(segmentedControlValue)]];
    row.selectorOptions = @[@"This control", @"Is dynamically", @"Filled"];
    [row setValueChanged:^{
        DLog(@"Segment changed: %d", [self.segmentedControlValue intValue]);
    }];
    [section addRow:row];
    
    //Image
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Let's finish with an image!"];
    [self addSection:section];
    
    //SegmentedControl
    row = [[BlazeTableRow alloc] initWithXibName:kImageTableViewCell];
    row.imageNameCenter = @"Blaze_Logo";
    [section addRow:row];
    
    //Some empty space looks better
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
}

@end









































