//
//  BDGRoundedView.m
//  GraafICT
//
//  Created by Bob de Graaf on 04/02/16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGRoundedView.h"

@implementation BDGRoundedView

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self createCorners:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self createCorners:self];
}

-(void)createCorners:(UIView *)viewToCorner
{
    self.opaque = false;
    self.clipsToBounds = true;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    
    NSUInteger options = 0;
    if(self.topLeftCorner)      options = options | UIRectCornerTopLeft;
    if(self.topRightCorner)     options = options | UIRectCornerTopRight;
    if(self.botLeftCorner)      options = options | UIRectCornerBottomLeft;
    if(self.botRightCorner)     options = options | UIRectCornerBottomRight;    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToCorner.bounds byRoundingCorners:options cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewToCorner.bounds;
    maskLayer.path = maskPath.CGPath;
    viewToCorner.layer.mask = maskLayer;
}



@end
