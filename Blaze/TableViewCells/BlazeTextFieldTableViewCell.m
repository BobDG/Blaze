//
//  BlazeTextFieldTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextFieldProcessor.h"
#import "BlazeTextFieldTableViewCell.h"

@interface BlazeTextFieldTableViewCell () <UITextFieldDelegate>
{
    
}

@property(nonatomic,strong) NSMutableArray *textFieldProcessors;

@end

@implementation BlazeTextFieldTableViewCell

-(void)updateCell
{
    //Processors
    if(!self.textFieldProcessors) {
        self.textFieldProcessors = [NSMutableArray new];
    }
    
    //First the main textfield
    for(int i = 0; i < 1+self.row.additionalRows.count; i++) {
        BlazeTextFieldProcessor *processor;
        if(i < self.textFieldProcessors.count) {
            //Get it
            processor = self.textFieldProcessors[i];
        }
        else {
            //Create it
            if(i == 0) {
                processor = [BlazeTextFieldProcessor new];
                processor.row = self.row;
                processor.textField = self.textField;
            }
            else {
                int index = i-1;
                if(index < self.additionalFields.count) {
                    processor = [BlazeTextFieldProcessor new];
                    processor.row = self.row.additionalRows[index];
                    processor.textField = self.additionalFields[index];
                }
                else {
                    break;
                }
            }
            
            //Add it
            [self.textFieldProcessors addObject:processor];
        }
        
        //Update if existing
        processor.textField.inputAccessoryView = [self defaultInputAccessoryViewToolbar];
        processor.cell = self;
        [processor update];
    }
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







