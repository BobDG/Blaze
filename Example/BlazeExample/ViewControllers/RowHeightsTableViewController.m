//
//  RowHeightsTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "RowHeightsTableViewController.h"

@implementation RowHeightsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Section header/footer
    self.tableView.estimatedSectionHeaderHeight = 40;
    self.tableView.estimatedSectionFooterHeight = 40;
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    //Section
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Blaze is very flexible. By default, rowheight is automatically based on autolayout constraints using UITableViewAutomaticDimension."];
    section.footerXibName = kTableFooterView;
    section.footerTitle = @"You can also say the rowheight should be dynamic and simply fill up the rest of the screen's height. It will calculate all other rowheights first and see how much space is left on the screen and assign that value. That will only work when you only use specific rowheights/ratios for all other rows though, not when using automatic rowheights based on constraints.";
    [self addSection:section];
    
    //Standard
    row = [[BlazeRow alloc] initWithXibName:kTextTableViewCell title:@"So this row will automatically become larger as long as you put your constraints in the right place! You can simply check the TextTableViewCell.xib file to see how it's done here. The same principle is used for the header/footer views."];
    [section addRow:row];
    
    //Hard
    row = [[BlazeRow alloc] initWithXibName:kTextTableViewCell title:@"You can also give it a very specific rowheight, e.g. 80"];
    row.rowHeight = @(80);
    [section addRow:row];
    
    //Ratio
    row = [[BlazeRow alloc] initWithXibName:kTextTableViewCell title:@"Or a ratio, e.g. 30% of the screen height"];
    row.rowHeightRatio = @(0.3f);
    [section addRow:row];
    
    //Reload
    [self.tableView reloadData];
}

@end
