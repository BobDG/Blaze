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

    //Xibs to use for every cell
    self.rowsXibName = kTextArrowTableViewCell;
    
    //Xibs to use for every header & footer
    self.headerXibName = kTableHeaderView;
    self.footerXibName = kTableFooterView;
    
    //Refreshcontrol test
    self.enableRefreshControl = TRUE;
    __weak __typeof(self)weakSelf = self;
    [self setRefreshControlPulled:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf endRefreshing];
            [weakSelf.tableView reloadData];
        });
    }];
    
    //Load table
    [self loadTable];
}

-(void)loadTable
{
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    //Section
    section = [[BlazeSection alloc] initWithHeaderTitle:@"Custom headerview\nSelect different examples of Blaze below."];
    section.footerTitle = @"Custom footerview.\nCheck the code how these viewcontrollers are pushed in various ways.";
    [self.tableArray addObject:section];
    
    //Rows with push using segue
    [section addRow:[BlazeRow rowWithTitle:@"Different cell types" segueIdentifier:@"CellTypesTableViewController"]];
    [section addRow:[[BlazeRow alloc] initWithXibName:kTextArrowTableViewCell title:@"Text views" segueIdentifier:@"TextViewsTableViewController"]];
    
    //Row with push using storyboard name/id
    row = [BlazeRow rowWithTitle:@"Dynamic rows"];
    row.storyboardName = @"Main";
    row.storyboardID = @"DynamicRowsTableViewController";
    [section addRow:row];
    
    //Row with push using cellTap completion block and storyboard instantiation
    row = [BlazeRow rowWithTitle:@"Zoom header"];
    [row setCellTapped:^{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZoomHeaderTableViewController"] animated:TRUE];
    }];
    [section addRow:row];
    
    //Row with push using cellTap completion block and programmatically creating viewcontroller
    row = [BlazeRow rowWithTitle:@"Row heights & ratios"];
    [row setCellTapped:^{
        RowHeightsTableViewController *vc = [[RowHeightsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        vc.title = @"Row heights & ratios";
        [self.navigationController pushViewController:vc animated:TRUE];
    }];
    [section addRow:row];
    
    //Segue again
    [section addRow:[[BlazeRow alloc] initWithTitle:@"Empty state" segueIdentifier:@"EmptyStateTableViewController"]];
}

@end














































