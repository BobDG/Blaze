//
//  BlazePickerViewMultipleField.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazePickerViewMultipleField.h"

@interface BlazePickerViewMultipleField () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    
}

@end

@implementation BlazePickerViewMultipleField

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

-(void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes
{
    _selectedIndexes = selectedIndexes;
    for(int i = 0; i < selectedIndexes.count; i++) {
        NSNumber *selectedIndex = selectedIndexes[i];
        [self.pickerView selectRow:selectedIndex.intValue inComponent:i animated:FALSE];
    }
}

-(void)pickerFieldCancelled
{
    //Reset values
    for(int i = 0; i < self.selectedIndexes.count; i++) {
        NSNumber *selectedIndex = self.selectedIndexes[i];
        [self.pickerView selectRow:selectedIndex.intValue inComponent:i animated:FALSE];
    }
    [self resignFirstResponder];
    if(self.pickerCancelled) {
        self.pickerCancelled();
    }
}

-(void)pickerFieldSelected
{
    [self resignFirstResponder];
    NSMutableArray *selectedIndexes = [NSMutableArray new];
    for(int i = 0; i < self.pickerView.numberOfComponents; i++) {
        [selectedIndexes addObject:@([self.pickerView selectedRowInComponent:i])];
    }
    self.selectedIndexes = selectedIndexes;
    if(self.pickerSelected) {
        self.pickerSelected(self.selectedIndexes);
    }
}

-(CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

#pragma mark - UIPickerView datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerValues.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *values = self.pickerValues[component];
    return values.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *values = self.pickerValues[component];
    return values[row];
}

-(nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *values = self.pickerValues[component];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:values[row]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21.0f] range:NSMakeRange(0, attributedString.string.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attributedString.string.length)];
    
    //Got ranges?
    if(!self.pickerColumnRanges || component != self.rangesColumnIndex) {
        return attributedString;
    }
    
    //Check if it falls within the range
    NSUInteger firstComponentSelectedRow = [self.pickerView selectedRowInComponent:self.mainColumnIndex];
    NSRange range = self.pickerColumnRanges[firstComponentSelectedRow].rangeValue;
    if(!NSLocationInRange(row, range)) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, attributedString.string.length)];
    }
    return attributedString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Got ranges?
    if(self.pickerColumnRanges) {
        //For first component
        if(component == self.mainColumnIndex) {
            //Reload first
            [self.pickerView reloadComponent:self.rangesColumnIndex];
            
            //Callback first component change
            if(self.pickerSelectionChanged) {
                self.pickerSelectionChanged((int)component, (int)row);
            }
        }
        
        //Check second component
        NSUInteger mainComponentSelectedRow = [self.pickerView selectedRowInComponent:self.mainColumnIndex];
        NSRange range = self.pickerColumnRanges[mainComponentSelectedRow].rangeValue;
        NSUInteger rangesComponentSelectedRow = [self.pickerView selectedRowInComponent:self.rangesColumnIndex];
        if(!NSLocationInRange(rangesComponentSelectedRow, range)) {
            int finalRow = (int)range.location+(int)range.length-1;
            [self.pickerView selectRow:finalRow inComponent:self.rangesColumnIndex animated:TRUE];
            if(self.pickerSelectionChanged) {
                self.pickerSelectionChanged(self.rangesColumnIndex, finalRow);
            }
        }
        else if(component != self.mainColumnIndex) {
            if(self.pickerSelectionChanged) {
                self.pickerSelectionChanged((int)component, (int)row);
            }
        }
        
        return;
    }
    
    
    //Default
    if(self.pickerSelectionChanged) {
        self.pickerSelectionChanged((int)component, (int)row);
    }
}

@end



























