//
//  BlazeTextFieldProcessor.m
//  Blaze
//
//  Created by Bob de Graaf on 27-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"
#import "BlazeTextFieldProcessor.h"

@interface BlazeTextFieldProcessor () <UITextFieldDelegate>
{
    
}

@property(nonatomic,strong) BlazeTextField *textField;

@end

@implementation BlazeTextFieldProcessor

-(void)update
{
    //Set textfield
    self.textField = self.field;
    
    //Formatter
    if(self.row.formatter) {
        if([self.row.formatter isKindOfClass:[NSNumberFormatter class]]) {
            self.textField.text =  [((NSNumberFormatter *)self.row.formatter) stringFromNumber:self.row.value];
        }
        else {
            self.textField.text = [self.row.formatter stringForObjectValue:self.row.value];
        }
    }
    else {
        self.textField.text = self.row.value;
    }
    
    //Suffixes & prefixes (only when textfield has a value already)
    [self updateTextFieldPrefixAndSuffix:self.textField];
    
    //Properties
    self.textField.keyboardType = self.row.keyboardType;
    self.textField.secureTextEntry = self.row.secureTextEntry;
    self.textField.autocorrectionType = self.row.autocorrectionType;
    if(self.row.capitalizationType) {
        self.textField.autocapitalizationType = [self.row.capitalizationType intValue];
    }
    
    //Merge BlazeRow's configuration with the BlazeTextField
    [self.textField mergeBlazeRowWithInspectables:self.row];
    
    //Editable
    self.textField.userInteractionEnabled = !self.row.disableEditing;
    
    //Update
    self.textField.delegate = self;
    
    //InputAccessoryView
    self.textField.inputAccessoryView = [self.cell defaultInputAccessoryViewToolbar];
}

#pragma mark - Prefix/Suffixes

-(void)updateTextFieldPrefixAndSuffix:(UITextField *)textField
{
    if(self.textField.text.length) {
        if(self.row.textFieldPrefix.length && self.row.textFieldSuffix.length) {
            textField.text = [NSString stringWithFormat:@"%@%@%@", self.row.textFieldPrefix, self.textField.text, self.row.textFieldSuffix];
        }
        else if(self.row.textFieldSuffix.length) {
            textField.text = [textField.text stringByAppendingString:self.row.textFieldSuffix];
        }
        else if(self.row.textFieldPrefix.length) {
            textField.text = [self.row.textFieldPrefix stringByAppendingString:self.textField.text];
        }
    }
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.row.textFieldSuffix.length) {
        textField.text = [textField.text stringByReplacingOccurrencesOfString:self.row.textFieldSuffix withString:@""];
    }
    if(self.row.textFieldPrefix.length) {
        textField.text = [textField.text stringByReplacingOccurrencesOfString:self.row.textFieldPrefix withString:@""];
    }
    if(self.row.textFieldDidBeginEditing) {
        self.row.textFieldDidBeginEditing(self.textField);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateTextFieldPrefixAndSuffix:textField];
    if(self.row.textFieldDidEndEditing) {
        self.row.textFieldDidEndEditing(self.textField);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.row.textFieldShouldChangeCharactersInRange) {
        BOOL result = self.row.textFieldShouldChangeCharactersInRange(self.textField, range, string);
        if(!result) {
            return FALSE;
        }
    }
    self.row.value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(self.row.formatter) {
        if([self.row.formatter isKindOfClass:[NSNumberFormatter class]]) {
            self.row.value = [self.row.value stringByReplacingOccurrencesOfString:@"," withString:@"."];
            textField.text = self.row.value;
            self.row.value = [((NSNumberFormatter *)self.row.formatter) numberFromString:self.row.value];
        }
        else {
            self.row.value = [self.row.formatter stringForObjectValue:self.row.value];
            textField.text = self.row.value;
        }
        [self.row updatedValue:self.row.value];
        return FALSE;
    }
    [self.row updatedValue:self.row.value];
    return TRUE;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{ 
    if(self.row.doneChanging) { 
        self.row.doneChanging();
    }
    if(self.cell.nextField) {
        [self.cell nextField:nil];        
    }
    else {
        [textField resignFirstResponder];
    }
    return TRUE;
}


@end
