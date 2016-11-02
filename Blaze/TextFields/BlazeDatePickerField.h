//
//  BlazeDatePickerField.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"

@interface BlazeDatePickerField : BlazeTextField
{
    
}

@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) UIDatePicker *datePicker;
@property(nonatomic,copy) void (^dateCancelled)(void);
@property(nonatomic,copy) void (^dateSelected)(NSDate *date);
@property(nonatomic,copy) void (^dateSelectionChanged)(NSDate *date);

@end
