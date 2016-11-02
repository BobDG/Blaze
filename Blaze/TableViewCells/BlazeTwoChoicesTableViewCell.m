//
//  BlazeTwoChoicesTableViewCell.m
//  BlazeExample
//
//  Created by Bob de Graaf on 21-07-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTwoChoicesTableViewCell.h"

@implementation BlazeTwoChoicesTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)updateCheckboxes
{
    if([self.row.value intValue] == 0) {
        self.choice1ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
        self.choice2ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
    }
    else if([self.row.value intValue] == 1) {
        self.choice1ImageView.image = [UIImage imageNamed:self.row.checkboxImageActive];
        self.choice2ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
    }
    else if([self.row.value intValue] == 2) {
        self.choice1ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
        self.choice2ImageView.image = [UIImage imageNamed:self.row.checkboxImageActive];
    }
}

-(void)updateCell
{
    //Update checkboxes
    [self updateCheckboxes];
}

-(IBAction)choice1Tapped:(id)sender
{
    if(self.row.disableEditing) {
        return;
    }
    
    self.row.value = @(1);
    [self choiceChanged];
}

-(IBAction)choice2Tapped:(id)sender
{
    if(self.row.disableEditing) {
        return;
    }
    
    self.row.value = @(2);
    [self choiceChanged];
}

-(void)choiceChanged
{    
    //Update checkboxes
    [self updateCheckboxes];
    
    //Update callback
    [self.row updatedValue:self.row.value];
}


@end
