//
//  BlazePickerFieldProcessor.m
//  BlazeExample
//
//  Created by Bob de Graaf on 29-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazePickerViewField.h"
#import "BlazePickerFieldProcessor.h"

@interface BlazePickerFieldProcessor () <UITextFieldDelegate>
{
    
}

@property(nonatomic,strong) BlazePickerViewField *pickerField;

@end

@implementation BlazePickerFieldProcessor

-(void)update
{
    //Set field
    self.pickerField = self.field;
    
    //AccessoryInputView
    [self updateAccessoryInputView];
    
    //Delegate
    self.pickerField.delegate = self;
    
    __weak __typeof(self)weakSelf = self;
    [self.pickerField setPickerCancelled:^{
        [weakSelf.pickerField resignFirstResponder];
    }];
    [self.pickerField setPickerSelected:^(int index) {
        [weakSelf.pickerField resignFirstResponder];
        [weakSelf updateSelectedIndex:index];
    }];
    
    //Editable
    self.pickerField.userInteractionEnabled = !self.row.disableEditing;
    
    //PickerValues (use immediate strings or possible object titles)
    NSString *textValue;
    NSMutableArray *pickerValues = [NSMutableArray new];
    if(self.row.pickerObjectPropertyName.length) {
        for(id object in self.row.selectorOptions) {
            [pickerValues addObject:[object valueForKey:self.row.pickerObjectPropertyName]];
        }
        if(self.row.value) {
            textValue = [self.row.value valueForKey:self.row.pickerObjectPropertyName];
        }
    }
    else {
        [pickerValues addObjectsFromArray:self.row.selectorOptions];
        if(self.row.value) {
            textValue = self.row.value;
        }
    }
    self.pickerField.pickerValues = pickerValues;
    
    //Merge BlazeRow's configuration with the BlazeTextField
    [self.pickerField mergeBlazeRowWithInspectables:self.row];
    
    //Index
    NSUInteger index = NSNotFound;
    
    //Get index based on usePickerIndex or not
    if(self.row.pickerUseIndexValue) {
        if(self.row.value) {
            index = [self.row.value integerValue];
        }
    }
    else {        
        if(textValue.length) {
            index = [pickerValues indexOfObject:textValue];
        }
    }
    
    //No index found
    if(index == NSNotFound) {
        self.pickerField.text = @"";
        return;
    }
    
    //Update index row & field
    if(index < pickerValues.count) {
        self.pickerField.text = pickerValues[index];
    }
    self.pickerField.selectedIndex = (int)index;
}

-(void)updateAccessoryInputView
{
    //Only for default inputAccessoryView
    if(self.row.inputAccessoryViewType != InputAccessoryViewCancelSave) {
        //Get toolbar
        self.pickerField.inputAccessoryView = [self.cell defaultInputAccessoryViewToolbar];
        
        //Update for changes
        __weak __typeof(self)weakSelf = self;
        [self.pickerField setPickerSelectionChanged:^(int index) {
            [weakSelf updateSelectedIndex:index];
        }];
    }
}

-(void)updateSelectedIndex:(int)index
{
    if(index < self.pickerField.pickerValues.count) {
        //Value
        if(self.row.pickerUseIndexValue) {
            self.row.value = @(index);
        }
        else {
            self.row.value = self.row.selectorOptions[index];
        }
        
        //Field text from strings or object
        self.pickerField.text = self.pickerField.pickerValues[index];
        
        //Set field text
        [self.row updatedValue:self.row.value];
    }
}

#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.row.inputAccessoryViewType == InputAccessoryViewCancelSave) {
        return;
    }
    
    if(self.pickerField.text.length) {
        return;
    }
    
    if(!self.row.selectorOptions.count) {
        return;
    }
    
    //Go
    [self updateSelectedIndex:0];
    
    //Callback
    if(self.row.textFieldDidBeginEditing) {
        self.row.textFieldDidBeginEditing(self.pickerField);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.row.textFieldDidEndEditing) {
        self.row.textFieldDidEndEditing(self.pickerField);
    }
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

@end
