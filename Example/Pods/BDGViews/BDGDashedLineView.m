//
//  BDGDashedLineView.m
//  GraafICT
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGDashedLineView.h"

@implementation BDGDashedLineView

#pragma mark - Draw Methods

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(cx);
    CGContextSetLineWidth(cx, _thickness);
    CGContextSetStrokeColorWithColor(cx, _color.CGColor);
    
    CGFloat dash[] = {_dashedLength,_dashedGap};
    CGContextSetLineDash(cx, 0, dash, 2);
    CGContextMoveToPoint(cx, 0, 0.0f);
    CGContextAddLineToPoint(cx, rect.size.width, 0.0f);
    CGContextStrokePath(cx);
    CGContextClosePath(cx);
}

@end
















