//
//  BDGBorderedView.m
//  GraafICT
//
//  Created by Bob de Graaf on 23-12-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGBorderedView.h"

@implementation BDGBorderedView

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self createBorder];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self createBorder];
}

-(void)createBorder
{
    self.opaque = false;
    self.clipsToBounds = true;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
}

@end
