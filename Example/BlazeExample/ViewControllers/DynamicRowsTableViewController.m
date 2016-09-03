//
//  DynamicRowsTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "DynamicRowsTableViewController.h"

typedef NS_ENUM(NSInteger, RowID) {
    RowShowRows,
    RowHowMany,
    RowImage
};

@interface DynamicRowsTableViewController ()
{
    
}

@property(nonatomic) int numberOfFields;
@property(nonatomic,strong) NSNumber *showRows;
@property(nonatomic,strong) BlazeRow *howManyFieldsRow;

@end

@implementation DynamicRowsTableViewController

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
    
    //Section
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Blaze is built to easily remove/add rows dynamically"];
    [self addSection:section];
    
    //Switch
    row = [[BlazeRow alloc] initWithXibName:kSwitchTableViewCell title:@"Show textfield row"];
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(showRows)]];
    [row setValueChanged:^{
        [self updateRows];
    }];
    [section addRow:row];
    row.ID = RowShowRows;
    
    //Textfield
    row = [[BlazeRow alloc] initWithXibName:kFloatTextFieldTableViewCell];
    row.placeholder = @"How many image fields?";
    row.keyboardType = UIKeyboardTypeNumberPad;
    __weak __typeof(BlazeRow *)weakRow = row;
    [row setValueChanged:^{
        self.numberOfFields = [weakRow.value intValue];
        DLog(@"Got new number of fields: %d", self.numberOfFields);
        [self updateRows];
    }];
    [row setConfigureCell:^(UITableViewCell *cell) {
        
    }];
    row.ID = RowHowMany;
    self.howManyFieldsRow = row;
}

-(void)updateRows
{
    //Remove previous image rows
    [self removeRowsInSection:0 fromIndex:RowImage];
    
    //Switch off?
    if(![self.showRows boolValue]) {
        [self removeRowsInSection:0 fromIndex:RowImage];
        [self removeRowWithID:RowHowMany withRowAnimation:UITableViewRowAnimationLeft];
        return;
    }
    
    //Switch on
    [self addRow:self.howManyFieldsRow afterRowID:RowShowRows withRowAnimation:UITableViewRowAnimationLeft];
    
    //How many?
    for(int i = 0; i < self.numberOfFields; i++) {
        BlazeRow *row = [[BlazeRow alloc] initWithXibName:kImageTableViewCell];
        row.imageNameCenter = @"Blaze_Logo";
        row.ID = RowImage+i;
        [self addRow:row afterRowID:row.ID-1 withRowAnimation:UITableViewRowAnimationBottom];
    }
}

@end








































