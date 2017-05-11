//
//  BlazeImagesScrollTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewCell.h"

@interface BlazeImagesScrollTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic) int imageWidth;
@property(nonatomic) int imagePadding;

@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;

@end
