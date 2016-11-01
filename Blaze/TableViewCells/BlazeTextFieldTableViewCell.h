//
//  BlazeTextFieldTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTextField.h"
#import "BlazeTableViewCell.h"

@interface BlazeTextFieldTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet BlazeTextField *textField;

@end
