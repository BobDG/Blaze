//
//  BlazeTextFieldProcessor.h
//  Blaze
//
//  Created by Bob de Graaf on 27-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BlazeRow.h"
#import "BlazeTextField.h"
#import "BlazeTableViewCell.h"

@interface BlazeTextFieldProcessor : NSObject
{
    
}

-(void)update;

@property(nonatomic,strong) BlazeRow *row;
@property(nonatomic,strong) BlazeTableViewCell *cell;
@property(nonatomic,strong) BlazeTextField *textField;

@end
