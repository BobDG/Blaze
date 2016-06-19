//
//  BasicTableViewController.m
//  Test
//
//  Created by Bob de Graaf on 15-03-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BasicTableViewController.h"
#import "RowHeightsTableViewController.h"

@implementation BasicTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Empty back button for pushed controllers
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    //Load table
    [self loadTable];
    
    //Xibs to use for every cell
    self.rowsXibName = kTextArrowTableViewCell;
}

-(void)loadTable
{
    //Row & Section
    BlazeTableRow *row;
    BlazeTableSection *section;
    
    //Section
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Custom headerview\nSelect different examples of Blaze below."];
    section.footerTitle = @"Custom footerview.\nCheck the code how these viewcontrollers are pushed in various ways.";
    section.footerXibName = kTableFooterView;    
    [self.tableArray addObject:section];
    
    //Rows with push using segue
    [section addRow:[[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Different cell types" segueIdentifier:@"CellTypesTableViewController"]];
    [section addRow:[[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Text views" segueIdentifier:@"TextViewsTableViewController"]];
    
    //Row with push using storyboard name/id
    row = [[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Dynamic rows"];
    row.storyboardName = @"Main";
    row.storyboardID = @"DynamicRowsTableViewController";
    [section addRow:row];
    
    //Row with push using cellTap completion block and storyboard instantiation
    row = [[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Zoom header"];
    [row setCellTapped:^{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZoomHeaderTableViewController"] animated:TRUE];
    }];
    [section addRow:row];
    
    //Row with push using cellTap completion block and programmatically creating viewcontroller
    row = [[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Row heights & ratios"];
    [row setCellTapped:^{
        RowHeightsTableViewController *vc = [[RowHeightsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        vc.title = @"Row heights & ratios";
        [self.navigationController pushViewController:vc animated:TRUE];
    }];
    [section addRow:row];
    
    //Segue again
    [section addRow:[[BlazeTableRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Empty state" segueIdentifier:@"EmptyStateTableViewController"]];
}

@end














































