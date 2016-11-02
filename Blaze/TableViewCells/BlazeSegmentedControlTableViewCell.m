//
//  BlazeSegmentedControlTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 26-06-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeSegmentedControlTableViewCell.h"

@implementation BlazeSegmentedControlTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Add action
    [self.segmentedControl addTarget:self action:@selector(segmentedChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)updateCell
{
    [self.segmentedControl removeAllSegments];
    for(int i = 0; i < self.row.selectorOptions.count; i++) {
        [self.segmentedControl insertSegmentWithTitle:self.row.selectorOptions[i] atIndex:i animated:FALSE];
    }
    
    self.segmentedControl.selectedSegmentIndex = [self.row.value intValue];
}

-(IBAction)segmentedChanged
{
    if(self.row.disableEditing) {
        return;
    }
    
    self.row.value = @(self.segmentedControl.selectedSegmentIndex);
    [self.row updatedValue:self.row.value];
}

@end
