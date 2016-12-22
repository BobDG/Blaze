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
    
    //Parallax
    self.headerParallaxScrollRatio = 0.3f;
    
    //Load table
    [self loadTable];
}

-(void)loadTable
{
    //Section
    BlazeSection *section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Draggable zoom header view & Optional parallax effect"];
    [self addSection:section];
}

@end
