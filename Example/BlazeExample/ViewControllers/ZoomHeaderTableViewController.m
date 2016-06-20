//
//  ZoomHeaderTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "ZoomHeaderTableViewController.h"

@interface ZoomHeaderTableViewController ()

@end

@implementation ZoomHeaderTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Looks better when not translucent
    self.navigationController.navigationBar.translucent = FALSE;
    self.navigationController.automaticallyAdjustsScrollViewInsets = FALSE;
    
    //ZoomHeader
    self.zoomTableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ZoomHeaderView" owner:nil options:nil].firstObject;
    
    //Load table
    [self loadTable];
}

-(void)loadTable
{
    //Section
    BlazeSection *section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Blaze comes with a draggable zoom header view with 1 line of code!"];
    [self addSection:section];
}

@end
