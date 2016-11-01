//
//  BlazePickerViewField.h
//  Blaze
//
//  Created by Bob de Graaf on 18-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"

@interface BlazePickerViewField : BlazeTextField
{
    
}

@property(nonatomic) int selectedIndex;
@property(nonatomic,strong) NSArray *pickerValues;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,copy) void (^pickerCancelled)(void);
@property(nonatomic,copy) void (^pickerSelected)(int index);
@property(nonatomic,copy) void (^pickerSelectionChanged)(int index);

@end
