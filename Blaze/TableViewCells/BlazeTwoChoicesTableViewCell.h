//
//  BlazeTwoChoicesTableViewCell.h
//  BlazeExample
//
//  Created by Bob de Graaf on 21-07-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewCell.h"

@interface BlazeTwoChoicesTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet UIImageView *choice1ImageView;
@property(nonatomic,weak) IBOutlet UIImageView *choice2ImageView;

@end
