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
    
    //Custom cells
    /*[self registerCustomCells:@[
                                kTextTableViewCell,
                                kImageTableViewCell,
                                kButtonTableViewCell,
                                kSliderTableViewCell,
                                kSwitchTableViewCell,
                                kCheckboxTableViewCell,
                                kTextViewTableViewCell,
                                kDateFieldTableViewCell,
                                kTextArrowTableViewCell,
                                kEmptySpaceTableViewCell,
                                kTwoChoicesTableViewCell,
                                kPickerFieldTableViewCell,
                                kFloatTextFieldTableViewCell,
                                kSegmentedControlTableViewCell,
                                ]];
     */
    
    //Custom header/footer
    //[self registerCustomHeader:kTableHeaderView];
    //[self registerCustomHeader:kTableFooterView];
}

@end
