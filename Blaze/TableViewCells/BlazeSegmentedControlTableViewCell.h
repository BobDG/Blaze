//
//  BlazeTableSegmentedControlCell.h
//  Blaze
//
//  Created by Bob de Graaf on 26-06-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewCell.h"

@interface BlazeSegmentedControlTableViewCell : BlazeTableViewCell
{
    
}

//Outlets
@property(nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;

@end