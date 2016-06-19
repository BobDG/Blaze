//
//  BDGRoundedView.m
//  GraafICT
//
//  Created by Bob de Graaf on 04/02/16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGRoundedView.h"

@implementation BDGRoundedView

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    self.opaque = NO;
    self.clipsToBounds = TRUE;
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(void)doCorner:(UIView*)viewToCorner {
    UIBezierPath *maskPath;
    
    NSUInteger options = 0;
    
    if(self.topLeftCorner)      options = options | UIRectCornerTopLeft;
    if(self.topRightCorner)     options = options | UIRectCornerTopRight;
    if(self.botLeftCorner)      options = options | UIRectCornerBottomLeft;
    if(self.botRightCorner)     options = options | UIRectCornerBottomRight;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToCorner.bounds byRoundingCorners:options cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewToCorner.bounds;
    maskLayer.path = maskPath.CGPath;
    
    viewToCorner.layer.mask = maskLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self doCorner:self];
    
//    TEMP
//    for (UIView* view in self.subviews) {
//        [self doCorner:view];
//        view.clipsToBounds = true;
//        view.opaque = false;
//        [view layoutIfNeeded];
//    }
}

@end
