//
//  BlazePickerViewField.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazePickerViewField.h"

@interface BlazePickerViewField () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    
}

@end

@implementation BlazePickerViewField

#pragma mark Init

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self) {
        return nil;
    }
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.inputView = self.pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerFieldCancelled)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(pickerFieldSelected)];
    [toolBar setItems:@[cancel, space, done]];
    [toolBar sizeToFit];
    self.inputAccessoryView = toolBar;
    
    return self;
}

-(void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self.pickerView selectRow:self.selectedIndex inComponent:0 animated:FALSE];
}

-(void)pickerFieldCancelled
{
    [self.pickerView selectRow:self.selectedIndex inComponent:0 animated:FALSE];
    [self resignFirstResponder];
    if(self.pickerCancelled) {
        self.pickerCancelled();
    }
}

-(void)pickerFieldSelected
{
    [self resignFirstResponder];
    self.selectedIndex = (int)[self.pickerView selectedRowInComponent:0];
    if(self.pickerSelected) {
        self.pickerSelected(self.selectedIndex);
    }
}

-(CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

#pragma mark - UIPickerView datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerValues.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerValues[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.pickerSelectionChanged) {
        self.pickerSelectionChanged((int)row);
    }
}

@end



























