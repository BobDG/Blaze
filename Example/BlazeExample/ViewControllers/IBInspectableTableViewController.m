//
//  IBInspectableTableViewController.m
//  BlazeExample
//
//  Created by Roy Derks on 15/11/2016.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "IBInspectableTableViewController.h"
#import "BlazeTextFieldTableViewCell.h"

@interface IBInspectableTableViewController () <UITextFieldDelegate>

@end

@implementation IBInspectableTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.loadContentOnAppear = TRUE;
}

-(void)loadTableContent
{
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    //BlazeTextField with IBInspectable's set in corresponding XIB file.
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Now an awesome float-label textfield with properties set through Interface Builder and code"];
    [self addSection:section];
    
    row = [BlazeRow rowWithXibName:kIBInspectableBlazeTextField];
    row.floatingTitle = @"I'm completely configured through IBInspectables!";
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:kIBInspectableBlazeTextField];
    row.floatingTitle = @"Now I'm orange whilst active!";
    row.floatingTitleActiveColor = [UIColor orangeColor];
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:kIBInspectableBlazeTextField];
    row.floatingLabelEnabled = FloatingLabelStateDisabled;
    row.placeholder = @"I don't use a floating label.";
    row.value = nil;
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:kIBInspectableBlazeTextField];
    row.placeholderColor = [UIColor orangeColor];
    row.floatingTitle = @"With a padded, blue Floating label!";
    row.floatingTitleColor = [UIColor blueColor];
    row.floatingTitleActiveColor = [UIColor blueColor];
    row.placeholder = @"I am an orange placeholder!";
    row.configureCell = ^(UITableViewCell *cell){
        BlazeTextFieldTableViewCell* aCell = (BlazeTextFieldTableViewCell*)cell;
        aCell.textField.flAlwaysShow = FALSE;
        aCell.textField.clipsToBounds = FALSE;
        aCell.textField.flYPadding = -20.f;
        [aCell updateCell];
    };
    row.value = nil;
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:kIBInspectableBlazeTextField];
    row.placeholder = @"I want my to be baseline altered when float-label is shown!";
    row.configureCell = ^(UITableViewCell *cell){
        BlazeTextFieldTableViewCell* aCell = (BlazeTextFieldTableViewCell*)cell;
        aCell.textField.flKeepBaseline = FALSE;
        [aCell updateCell];
    };
    row.value = nil;
    [section addRow:row];
    
    
    [self reloadTable:true];
}

@end
