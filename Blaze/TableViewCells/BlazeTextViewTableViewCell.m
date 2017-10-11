//
//  BlazeTableTextViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextViewTableViewCell.h"

@interface BlazeTextViewTableViewCell () <UITextViewDelegate>
{
    
}

@property(nonatomic) float previousHeight;
@property(nonatomic) float preferredHeightOneLine;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation BlazeTextViewTableViewCell

-(void)updateCell
{
    //Text
    self.textView.text = self.row.value;
    
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
    self.textView.inputAccessoryView = self.defaultInputAccessoryViewToolbar;
    
    //Reset height constraint because height will be resetted otherwise
    [self updateHeightConstraint];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.textView.delegate = self;
    
    //Scrolling
    self.textView.scrollsToTop = FALSE;
    self.textView.scrollEnabled = FALSE;
    
    //Set constant
    self.previousHeight = self.textViewHeightConstraint.constant;
    self.preferredHeightOneLine = self.previousHeight;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.textView.userInteractionEnabled) {
        [self.textView becomeFirstResponder];
    }
}

-(void)done
{
    [self.textView resignFirstResponder];    
}

#pragma mark - Constraint

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
        self.textViewHeightConstraint.constant = newConstant;
        self.previousHeight = newConstant;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        return TRUE;
    }
    return FALSE;
}

#pragma mark - UITextViewDelegate

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if([self updateHeightConstraint]) {
        if(self.heightUpdated) {
            self.heightUpdated();
        }
    }
    self.row.value = textView.text;
    [self.row updatedValue:self.row.value];
}
#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return self.textView.userInteractionEnabled;
}

-(BOOL)becomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}


@end






























