//
//  BlazeCheckboxTableViewCell.m
//  BlazeExample
//
//  Created by Bob de Graaf on 20-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeCheckboxTableViewCell.h"

@implementation BlazeCheckboxTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)updateCell
{
    //Update image
    [self updateCheckboxImage];
}

-(void)updateCheckboxImage
{
    if([self.row.value boolValue]) {
        self.checkboxImageView.image = [UIImage imageNamed:self.row.checkboxImageActive];
    }
    else {
        self.checkboxImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && !self.row.disableEditing) {
        [self checkboxTapped];
    }
}

-(void)checkboxTapped
{
    //Update value
    self.row.value = @(![self.row.value boolValue]);
    
    //Update image
    [self updateCheckboxImage];
    
    //Update callback
    [self.row updatedValue:self.row.value];
}

@end
