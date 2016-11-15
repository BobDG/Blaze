//
//  EmptyStateTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "EmptyStateTableViewController.h"

@interface EmptyStateTableViewController ()

@end

@implementation EmptyStateTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //Empty state
    self.emptyImage = [UIImage imageNamed:@"Blaze_Logo"];
    self.emptyBackgroundColor = [UIColor whiteColor];
    self.emptyVerticalOffset = -100.0f;
    self.emptyTitle = @"This is an example text for an empty state, you can provide colors, atributed text, image, background color, etc.\nCredits to DZNEmptyDataSet!";
    self.emptyTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f weight:UIFontWeightLight], NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    self.emptyBackgroundColor = [UIColor redColor];
    
    //Empty state custom view
    /*
    UIView *view = [UIView new];
    self.emptyVerticalOffset = -400.0f;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 250, 50)];
    lbl.text = @"Custom label!";
    lbl.backgroundColor = [UIColor yellowColor];
    [view addSubview:lbl];
    self.emptyCustomView = view;
     */
}

@end
