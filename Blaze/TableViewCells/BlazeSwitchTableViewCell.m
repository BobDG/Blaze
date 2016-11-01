//
//  BlazeTableSwitchCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeSwitchTableViewCell.h"

@implementation BlazeSwitchTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Target
    [self.cellSwitch addTarget:self action:@selector(cellSwitched:) forControlEvents:UIControlEventValueChanged];
}

-(IBAction)cellSwitched:(id)sender
{
    if(self.row.disableEditing) {
        return;
    }
    
    self.row.value = @(self.cellSwitch.on);
    [self.row updatedValue:self.row.value];
}

-(void)updateCell
{
    self.cellSwitch.on = [self.row.value boolValue];
    
    //Editable
    self.cellSwitch.userInteractionEnabled = !self.row.disableEditing;
}

@end
