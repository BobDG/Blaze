//
//  BlazeTextFieldTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextFieldProcessor.h"
#import "BlazeTextFieldTableViewCell.h"

@interface BlazeTextFieldTableViewCell ()
{
    
}

@end

@implementation BlazeTextFieldTableViewCell

-(void)updateCell
{
    //Setup processors
    [self setupFieldProcessorsWithMainField:self.textField processorClass:[BlazeTextFieldProcessor class]];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.textField.userInteractionEnabled) {
        [self.textField becomeFirstResponder];
    }
}

#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return self.textField.userInteractionEnabled;
}

-(BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

@end







