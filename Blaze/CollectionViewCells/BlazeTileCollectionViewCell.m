//
//  BlazeTileCollectionViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 07-10-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BlazeTileCollectionViewCell.h"

@implementation BlazeTileCollectionViewCell

-(void)setHighlighted:(BOOL)highlighted
{
    self.active = highlighted;
}

-(void)setSelected:(BOOL)selected
{
    self.active = selected;
}

-(void)setInputTile:(BlazeInputTile *)inputTile
{
    if(_inputTile == inputTile) {
        return;
    }
    
    _inputTile = inputTile;
    
    self.titleLabel.text = self.inputTile.text;
    if(self.bundle) {
        [self.imageView setImage:[[UIImage imageNamed:self.inputTile.imageName inBundle:self.bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    }
    else {
        [self.imageView setImage:[[UIImage imageNamed:self.inputTile.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    }
}

-(void)setActive:(bool)active
{
    _active = active;
    
    if(active) {
        self.imageView.tintColor = self.inputTile.baseColor;
        self.titleLabel.textColor = self.inputTile.baseColor;
        self.containerView.backgroundColor = self.inputTile.tintColor;
    }
    else {
        self.imageView.tintColor = self.inputTile.tintColor;
        self.titleLabel.textColor = self.inputTile.tintColor;
        self.containerView.backgroundColor = [UIColor clearColor];
    }
}

@end
