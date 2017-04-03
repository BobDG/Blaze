//
//  CollapsingSectionsTableViewController.m
//  BlazeExample
//
//  Created by Bob de Graaf on 03-04-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "CollapsingSectionsTableViewController.h"

@interface CollapsingSectionsTableViewController ()

@end

@implementation CollapsingSectionsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Title
    self.navigationItem.title = NSLocalizedString(@"Collapsing sections", @"");
    
    //Caching - best to use this to for example show arrows animating while collapsing
    self.sectionHeaderCaching = TRUE;
    
    //Xibs to use for every header
    self.headerXibName = kTableHeaderView;
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    for(int i = 0; i < 3; i++) {
        //Section
        section = [BlazeSection new];
        section.canCollapse = TRUE;
        section.headerHeight = @(40.0f);
        section.headerTitle = [NSString stringWithFormat:@"Section %d", i+1];
        [self.tableArray addObject:section];
        
        //Rows
        for(int j = 0; j < 1+arc4random()%5; j++) {
            row = [BlazeRow rowWithXibName:kTextTableViewCell title:[NSString stringWithFormat:@"Row %d", j]];
            [section addRow:row];
        }
    }   
    
    //Reload
    [self.tableView reloadData];
}

@end
