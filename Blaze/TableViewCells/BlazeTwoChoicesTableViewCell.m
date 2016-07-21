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
    if(self.choice == ChoiceNone) {
        self.choice1ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
        self.choice2ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
    }
    else if(self.choice == ChoiceOne) {
        self.choice1ImageView.image = [UIImage imageNamed:self.row.checkboxImageActive];
        self.choice2ImageView.image = [UIImage imageNamed:self.row.checkboxImageInactive];
    }
    else if(self.choice == ChoiceTwo) {
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
    self.choice = ChoiceOne;
    [self choiceChanged];
}

-(IBAction)choice2Tapped:(id)sender
{
    self.choice = ChoiceTwo;
    [self choiceChanged];
}

-(void)choiceChanged
{
    //Update value
    self.row.value = @(self.choice);
    
    //Update checkboxes
    [self updateCheckboxes];
    
    //Update callback
    [self.row updatedValue:self.row.value];
}


@end
