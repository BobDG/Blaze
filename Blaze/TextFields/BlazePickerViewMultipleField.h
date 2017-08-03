//
//  BlazePickerViewMultipleField.h
//  Blaze
//
//  Created by Bob de Graaf on 18-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"

@interface BlazePickerViewMultipleField : BlazeTextField
{
    
}

@property(nonatomic) int mainColumnIndex;
@property(nonatomic) int rangesColumnIndex;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) NSArray <NSArray *> *pickerValues;
@property(nonatomic,strong) NSArray <NSNumber *> *selectedIndexes;
@property(nonatomic,strong) NSArray <NSValue *> *pickerColumnRanges;

@property(nonatomic,copy) void (^pickerCancelled)(void);
@property(nonatomic,copy) void (^pickerSelected)(NSArray <NSNumber *> *selectedIndexes);
@property(nonatomic,copy) void (^pickerSelectionChanged)(int sectionIndex, int selectedIndex);

@end
