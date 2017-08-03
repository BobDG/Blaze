//
//  BlazePickerFieldMultipleProcessor.m
//  BlazeExample
//
//  Created by Bob de Graaf on 29-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazePickerViewMultipleField.h"
#import "BlazePickerFieldMultipleProcessor.h"

@interface BlazePickerFieldMultipleProcessor () <UITextFieldDelegate>
{
    
}

@property(nonatomic,strong) BlazePickerViewMultipleField *pickerField;

@end

@implementation BlazePickerFieldMultipleProcessor

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
    [self.pickerField setPickerSelected:^(NSArray <NSNumber *> *selectedIndexes) {
        [weakSelf.pickerField resignFirstResponder];
        [weakSelf updateSelectedIndexes:selectedIndexes];
    }];
    
    //Editable
    self.pickerField.userInteractionEnabled = !self.row.disableEditing;
    
    //Set initial text value
    NSString *textValue = @"";
    NSMutableArray *pickerValues = [[NSMutableArray alloc] initWithArray:self.row.selectorOptions];
    if(self.row.value) {
        NSArray *rowValues = (NSArray *)self.row.value;
        for(int i = 0; i < rowValues.count; i++) {
            int index = [rowValues[i] intValue];
            NSArray *options = pickerValues[i];
            if(i == rowValues.count-1) {
                textValue = [textValue stringByAppendingString:options[index]];
            }
            else {
                textValue = [textValue stringByAppendingFormat:@"%@ ", options[index]];
            }
        }
    }
    else {
        self.pickerField.text = @"";
    }
    
    //Merge BlazeRow's configuration with the BlazeTextField
    [self.pickerField mergeBlazeRowWithInspectables:self.row];
    
    //Set picker values
    self.pickerField.pickerValues = pickerValues;
    self.pickerField.mainColumnIndex = self.row.mainColumnIndex;
    self.pickerField.rangesColumnIndex = self.row.rangesColumnIndex;
    self.pickerField.pickerColumnRanges = self.row.selectorOptionsColumnRanges;
    self.pickerField.selectedIndexes = self.row.value;
    self.pickerField.text = textValue;
}

-(void)updateAccessoryInputView
{
    //Only for default inputAccessoryView
    if(self.row.inputAccessoryViewType != InputAccessoryViewCancelSave) {
        //Get toolbar
        self.pickerField.inputAccessoryView = [self.cell defaultInputAccessoryViewToolbar];
        
        //Update for changes
        __weak __typeof(self)weakSelf = self;
        [self.pickerField setPickerSelectionChanged:^(int section, int index) {
            NSMutableArray *rowValues = [[NSMutableArray alloc] initWithArray:weakSelf.row.value];
            rowValues[section] = @(index);
            [weakSelf updateSelectedIndexes:rowValues];
        }];
    }
}

-(void)updateSelectedIndexes:(NSArray <NSNumber *> *)selectedIndexes
{
    NSString *pickerFieldText = @"";
    NSMutableArray *rowValues = [[NSMutableArray alloc] initWithArray:self.row.value];
    for(int i = 0; i < selectedIndexes.count; i++) {
        int index = selectedIndexes[i].intValue;
        NSArray *pickerValues = self.pickerField.pickerValues[i];
        if(index >= pickerValues.count) {
            //Something went wrong, let's stop here
            NSLog(@"Index higher than values count, something not ok here, check please");
            return;
        }
        
        //Value
        rowValues[i] = @(index);
        
        //Text
        if(i == selectedIndexes.count-1) {
            pickerFieldText = [pickerFieldText stringByAppendingFormat:@"%@ ", [NSString stringWithFormat:@"%@ ", pickerValues[index]]];
        }
        else {
            pickerFieldText = [pickerFieldText stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@ ", pickerValues[index]]];
        }
        
        //Set field text
        [self.row updatedValue:self.row.value];
    }
    
    //Text
    self.pickerField.text = pickerFieldText;
    
    //Row value
    self.row.value = rowValues;
    [self.row updatedValue:self.row.value];
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
    
    //Set initial 0 values
    NSMutableArray *initialValues = [NSMutableArray new];
    for(int i = 0; i < self.row.selectorOptions.count; i++) {
        [initialValues addObject:@(0)];
    }
    [self updateSelectedIndexes:initialValues];
    
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
