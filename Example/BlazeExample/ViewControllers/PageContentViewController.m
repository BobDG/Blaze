//
//  PageContentViewController.m
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTableContent];
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Blaze
    BlazeSection *section = [BlazeSection new];
    BlazeRow *row;
    [self addSection:section];
    
    //Row
    row = [BlazeRow rowWithXibName:@"ButtonTableViewCell"];
    row.buttonCenterTitle = @"Next";
    row.buttonCenterTapped = ^ () {
        [self next:nil];
    };
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:@"ButtonTableViewCell"];
    row.buttonCenterTitle = @"Previous";
    row.buttonCenterTapped = ^ () {
        [self previous:nil];
    };
    [section addRow:row];
    
    [self reloadTable:false];
}

@end
