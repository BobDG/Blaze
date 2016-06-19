//
//  BlazePickerViewTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewCell.h"
#import "BlazePickerViewField.h"

@interface BlazePickerViewTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet BlazePickerViewField *pickerField;

@end
