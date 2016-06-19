//
//  BlazeTableTextViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTextView.h"
#import "BlazeTableViewCell.h"

@interface BlazeTextViewTableViewCell : BlazeTableViewCell
{
    
}

//Outlets
@property(nonatomic,weak) IBOutlet BlazeTextView *textView;

@end