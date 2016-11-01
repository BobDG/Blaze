//
//  BlazeTableDateCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeDateTableViewCell.h"

@interface BlazeTableViewCell () <UITextFieldDelegate>

@end

@implementation BlazeDateTableViewCell

-(void)updateCell
{
    //AccessoryInputView
    [self updateAccessoryInputView];
    
    //Date & formatter
    self.date = self.row.value;
    self.dateFormatter = self.row.dateFormatter;
    self.dateField.placeholder = self.row.placeholder;
    self.dateField.datePicker.datePickerMode = self.row.datePickerMode;
    
    //Min date
    if(self.row.minDate) {
        self.dateField.datePicker.minimumDate = self.row.minDate;
    }
    
    //Max date
    if(self.row.maxDate) {
        self.dateField.datePicker.maximumDate = self.row.maxDate;
    }
    
    //Minute interval
    if(self.row.dateMinuteInterval) {
        self.dateField.datePicker.minuteInterval = self.row.dateMinuteInterval;
    }
    
    //Update datepicker & datefield
    if(self.date) {
        self.dateField.date = self.date;
        if(self.dateFormatter) {
            self.dateField.text = [self.dateFormatter stringFromDate:self.date];
        }
    }
    else {
        self.dateField.text = @"";
        if(self.row.placeholderDate) {
            self.dateField.datePicker.date = self.row.placeholderDate;
        }
    }
    
    //Placeholder
    if(self.row.attributedPlaceholder.length) {
        self.dateField.attributedPlaceholder = self.row.attributedPlaceholder;
    }
    else if(self.row.placeholder.length && self.row.placeholderColor) {
        self.dateField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.row.placeholder attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    else if(self.row.placeholder.length) {
        self.dateField.placeholder = self.row.placeholder;
    }
    
    //Update for floating options
    self.dateField.useFloatingLabel = self.row.floatingPlaceholder;
    if(self.row.floatingPlaceholder) {
        self.dateField.floatingLabelFont = self.row.floatingLabelFont;
        self.dateField.floatingLabelTextColor = self.row.floatingPlaceholderColor;
        self.dateField.floatingLabelActiveTextColor = self.row.floatingPlaceholderActiveColor;
        if(self.row.floatingTitle.length) {
            self.dateField.floatingLabelText = self.row.floatingTitle;
        }
    }
    
    //Editable
    self.dateField.userInteractionEnabled = !self.row.disableEditing;    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.dateField.userInteractionEnabled) {
        [self.dateField becomeFirstResponder];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.dateField.delegate = self;
    
    __weak __typeof(self)weakSelf = self;
    [self.dateField setDateCancelled:^{
        [weakSelf.dateField resignFirstResponder];
    }];
    [self.dateField setDateSelected:^(NSDate *date) {
        [weakSelf updateSelectedDate:date];
    }];
}

-(void)updateAccessoryInputView
{
    //Only for default inputAccessoryView
    if(self.row.inputAccessoryViewType == InputAccessoryViewDefault) {
        //Get toolbar
        self.dateField.inputAccessoryView = [self defaultInputAccessoryViewToolbar];
        
        //Update
        __weak __typeof(self)weakSelf = self;
        [self.dateField setDateSelectionChanged:^(NSDate *date) {
            [weakSelf updateSelectedDate:date];
        }];
    }
}

-(IBAction)cellTapped:(id)sender
{
    [self.dateField becomeFirstResponder];
}

-(void)updateSelectedDate:(NSDate *)date
{
    self.date = date;
    self.row.value = date;
    if(self.dateFormatter) {
        self.dateField.text = [[self.dateFormatter stringFromDate:date] capitalizedString];
    }
    [self.row updatedValue:date];
}

#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.row.inputAccessoryViewType == InputAccessoryViewCancelSave) {
        return;
    }
    
    if(self.dateField.text.length) {
        return;
    }
    
    //Go
    [self updateSelectedDate:self.dateField.datePicker.date];
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





























