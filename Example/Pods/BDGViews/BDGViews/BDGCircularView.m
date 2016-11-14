//
//  BDGCircularView.m
//  GraafICT
//
//  Created by Bob de Graaf on 18-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGCircularView.h"

@implementation BDGCircularView

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self createCircle];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self createCircle];
}

-(void)createCircle
{
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = [self radiusForBounds:self.frame];
}

-(CGFloat)radiusForBounds:(CGRect)bounds
{
    float smallestSize = fminf(bounds.size.width, bounds.size.height);
    float radius = smallestSize/2;
    return radius;
}

@end
