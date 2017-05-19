//
//  BlazeDateFieldProcessor.m
//  BlazeExample
//
//  Created by Bob de Graaf on 28-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeDatePickerField.h"
#import "BlazeDateFieldProcessor.h"

@interface BlazeDateFieldProcessor () <UITextFieldDelegate>
{
    
}

//Properties
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSDateFormatter *dateFormatter;
@property(nonatomic,strong) BlazeDatePickerField *dateField;

@end

@implementation BlazeDateFieldProcessor

-(void)update
{
    //Set field
    self.dateField = self.field;
    
    //Date & formatter
    self.date = self.row.value;
    self.dateFormatter = self.row.dateFormatter;
    self.dateField.placeholder = self.row.placeholder;
    self.dateField.datePicker.datePickerMode = self.row.datePickerMode;
    
    //Min date
    self.dateField.datePicker.minimumDate = self.row.minDate;
    
    //Max date
    self.dateField.datePicker.maximumDate = self.row.maxDate;
    
    //Minute interval
    if(self.row.dateMinuteInterval) {
        self.dateField.datePicker.minuteInterval = self.row.dateMinuteInterval;
    }
    
    //Update datepicker & datefield
    if(self.date) {
        self.dateField.date = self.date;
        if(self.dateFormatter) {
            if(self.row.dateFormatCapitalizedString) {
                self.dateField.text = [[self.dateFormatter stringFromDate:self.date] capitalizedString];
            }
            else {
                self.dateField.text = [self.dateFormatter stringFromDate:self.date];
            }
        }
    }
    else {
        self.dateField.text = @"";
        if(self.row.placeholderDate) {
            self.dateField.datePicker.date = self.row.placeholderDate;
        }
    }
    
    //Merge BlazeRow's configuration with the BlazeTextField
    [self.dateField mergeBlazeRowWithInspectables:self.row];
    
    //Editable
    self.dateField.userInteractionEnabled = !self.row.disableEditing;
    
    //AccessoryInputView
    [self updateAccessoryInputView];
    
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
    if(self.row.inputAccessoryViewType != InputAccessoryViewCancelSave) {
        //Get toolbar
        self.dateField.inputAccessoryView = [self.cell defaultInputAccessoryViewToolbar];
        
        //Update
        __weak __typeof(self)weakSelf = self;
        [self.dateField setDateSelectionChanged:^(NSDate *date) {
            [weakSelf updateSelectedDate:date];
        }];
    }
}

-(void)updateSelectedDate:(NSDate *)date
{
    self.date = date;
    self.row.value = date;
    if(self.dateFormatter) {
        //Special case - capitalzed final text (not possible with NSDateFormatter unfortunately...)
        if(self.row.dateFormatCapitalizedString) {
            self.dateField.text = [[self.dateFormatter stringFromDate:date] capitalizedString];
        }
        else {
            self.dateField.text = [self.dateFormatter stringFromDate:date];
        }
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
    
    //Callback
    if(self.row.textFieldDidBeginEditing) {
        self.row.textFieldDidBeginEditing(self.dateField);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.row.textFieldDidEndEditing) {
        self.row.textFieldDidEndEditing(self.dateField);
    }
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

@end















