//
//  BaseTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Empty state
    self.emptyBackgroundColor = [UIColor whiteColor];
    
    //Section header/footer
    self.tableView.estimatedSectionHeaderHeight = 40;
    self.tableView.estimatedSectionFooterHeight = 40;
}

@end
