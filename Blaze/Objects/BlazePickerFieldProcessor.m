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
        textValue = self.row.value;
        [pickerValues addObjectsFromArray:self.row.selectorOptions];
    }
    self.pickerField.pickerValues = pickerValues;
    
    //Get index
    NSUInteger index = NSNotFound;
    if(textValue.length) {
        index = [pickerValues indexOfObject:textValue];
    }
    
    //Merge BlazeRow's configuration with the BlazeTextField
    [self.pickerField mergeBlazeRowWithInspectables:self.row];
    
    //No index check
    if(index == NSNotFound) {
        self.pickerField.text = @"";
        return;
    }
    
    //Update index row & field
    if(index < pickerValues.count) {
        self.pickerField.text = pickerValues[index];
    }
    self.pickerField.selectedIndex = (int)index;
    
    //Editable
    self.pickerField.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
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
}

-(void)updateAccessoryInputView
{
    //Only for default inputAccessoryView
    if(self.row.inputAccessoryViewType == InputAccessoryViewDefault) {
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
        self.row.value = self.row.selectorOptions[index];
        
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
}

@end
