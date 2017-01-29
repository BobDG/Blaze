//
//  BlazeTableDateCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeDateFieldProcessor.h"
#import "BlazeDateTableViewCell.h"

@interface BlazeTableViewCell ()

@end

@implementation BlazeDateTableViewCell

-(void)updateCell
{
    //Setup processors
    [self setupFieldProcessorsWithMainField:self.dateField processorClass:[BlazeDateFieldProcessor class]];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.dateField.userInteractionEnabled) {
        [self.dateField becomeFirstResponder];
    }
}

#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return self.dateField.userInteractionEnabled;
}

-(BOOL)becomeFirstResponder
{
    return [self.dateField becomeFirstResponder];
}

@end





























