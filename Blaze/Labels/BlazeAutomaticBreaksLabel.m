//
//  BlazeAutomaticBreaksLabel.m
//  BlazeExample
//
//  Created by Bob de Graaf on 04-04-18.
//  Copyright © 2018 GraafICT. All rights reserved.
//

#import "BlazeAutomaticBreaksLabel.h"

@implementation BlazeAutomaticBreaksLabel

-(void)drawTextInRect:(CGRect)rect
{
    //Calculate best rect width
    CGRect oneLineRect = [self textRectForBounds:CGRectInfinite limitedToNumberOfLines:1];
    NSInteger numberOfLines = ceil(oneLineRect.size.width / self.bounds.size.width);
    CGFloat betterWidth = (oneLineRect.size.width / numberOfLines);
    if (betterWidth < rect.size.width) {
        CGRect check = CGRectZero;
        do {
            betterWidth *= 1.1;
            CGRect b = CGRectMake(0, 0, betterWidth, CGRectInfinite.size.height);
            check = [self textRectForBounds:b limitedToNumberOfLines:0];
        } while (check.size.height > rect.size.height && betterWidth < rect.size.width);
        
        if (betterWidth < rect.size.width) {
            CGFloat difference = rect.size.width - betterWidth;
            //Shift the rect according to the text alignment
            if(self.textAlignment == NSTextAlignmentCenter) {
                rect = CGRectMake(rect.origin.x + difference/2.0, rect.origin.y, betterWidth, rect.size.height);
            }
            else if(self.textAlignment == NSTextAlignmentLeft) {
                rect = CGRectMake(rect.origin.x, rect.origin.y, betterWidth, rect.size.height);
            }
            else if(self.textAlignment == NSTextAlignmentRight) {
                rect = CGRectMake(rect.origin.x + difference, rect.origin.y, betterWidth, rect.size.height);
            }
        }
    }
    [super drawTextInRect:rect];
}

@end
