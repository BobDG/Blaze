//
//  BlazeTextViewProcessor.m
//  BlazeExample
//
//  Created by Bob de Graaf on 27/01/2019.
//  Copyright © 2019 GraafICT. All rights reserved.
//

#import "BlazeTextView.h"
#import "BlazeTextViewProcessor.h"

@interface BlazeTextViewProcessor() <UITextViewDelegate> {
    
}

@property(nonatomic) float previousHeight;
@property(nonatomic) float preferredHeightOneLine;
@property(nonatomic,strong) BlazeTextView *textView;

@end

@implementation BlazeTextViewProcessor

-(void)update
{
    if(!self.row) {
        return;
    }
    
    //Set textview
    self.textView = self.input;
    
    //Text
    self.textView.text = self.row.value;
    
    //Placeholder
    if(self.row.attributedPlaceholder.length) {
        self.textView.attributedPlaceholder = self.row.attributedPlaceholder;
    }
    else if(self.row.placeholder.length && self.row.placeholderColor) {
        self.textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.row.placeholder attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    else if(self.row.placeholder.length) {
        self.textView.placeholder = self.row.placeholder;
    }
    
    //Editable
    self.textView.userInteractionEnabled = !self.row.disableEditing;
    
    //AccessoryInputView
    if(self.cell) {
        self.textView.inputAccessoryView = [self.cell defaultInputAccessoryView];
    }
    
    //Delegate
    self.textView.delegate = self;
    
    //Scrolling
    self.textView.scrollsToTop = FALSE;
    self.textView.scrollEnabled = FALSE;
    
    //Set constant
    if(self.cell) {
        self.previousHeight = self.cell.textViewHeightConstraint.constant;
    }
    self.preferredHeightOneLine = self.previousHeight;
    
    //Reset height constraint because height will be resetted otherwise
    [self updateHeightConstraint];
}

-(BOOL)canBecomeFirstResponder
{
    return TRUE;
}

#pragma mark - Constraints

-(BOOL)updateHeightConstraint
{
    float heightThatFitsTextView = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)].height;
    float newConstant;
    if(heightThatFitsTextView>self.preferredHeightOneLine) {
        newConstant = heightThatFitsTextView;
    }
    else {
        newConstant = self.preferredHeightOneLine;
    }
    if(newConstant != self.previousHeight) {
        if(self.cell) {
            self.cell.textViewHeightConstraint.constant = newConstant;
            self.previousHeight = newConstant;
            [self.cell setNeedsUpdateConstraints];
            [self.cell layoutIfNeeded];
        }
        return TRUE;
    }
    return FALSE;
}

#pragma mark - UITextViewDelegate

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(!self.row) {
        return;
    }
    
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(!self.row) {
        return;
    }
    
    if([self updateHeightConstraint]) {
        if(self.cell) {
            if(self.cell.heightUpdated) {
                self.cell.heightUpdated();
            }
        }
    }
    self.row.value = textView.text;
    [self.row updatedValue:self.row.value];
}

@end
