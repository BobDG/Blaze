//
//  BlazeTileCollectionViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 15-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeInputTile.h"

@interface BlazeTileCollectionViewCell : UICollectionViewCell
{
    
}

@property(nonatomic) bool active;

@property(nonatomic,strong) NSBundle *bundle;
@property(nonatomic,strong) BlazeInputTile *inputTile;

@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UIView *containerView;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;

@end
