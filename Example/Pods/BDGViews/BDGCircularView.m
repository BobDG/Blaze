//
//  BDGCircularView.m
//  GraafICT
//
//  Created by Bob de Graaf on 18-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGCircularView.h"

@implementation BDGCircularView

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Circular properties
    self.opaque = NO;
    self.clipsToBounds = TRUE;
    self.layer.cornerRadius = [self radiusForBounds:self.bounds];
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //IBInspectables
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
}

-(void)setBounds:(CGRect)bounds
{
    self.layer.cornerRadius = [self radiusForBounds:bounds];
    [super setBounds:bounds];
}

-(CGFloat)radiusForBounds:(CGRect)bounds
{
    return fminf(bounds.size.width, bounds.size.height) / 2;
}

/*-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id<CAAction> action = [super actionForLayer:layer forKey:event];
    
    if ([event isEqualToString:@"cornerRadius"])
    {
        CABasicAnimation *boundsAction = (CABasicAnimation *)[self actionForLayer:layer forKey:@"bounds"];
        if ([boundsAction isKindOfClass:[CABasicAnimation class]] && [boundsAction.fromValue isKindOfClass:[NSValue class]])
        {
            CABasicAnimation *cornerRadiusAction = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            cornerRadiusAction.delegate = boundsAction.delegate;
            cornerRadiusAction.duration = boundsAction.duration;
            cornerRadiusAction.fillMode = boundsAction.fillMode;
            cornerRadiusAction.timingFunction = boundsAction.timingFunction;
            
            CGRect fromBounds = [(NSValue *)boundsAction.fromValue CGRectValue];
            CGFloat fromRadius = [self radiusForBounds:fromBounds];
            cornerRadiusAction.fromValue = [NSNumber numberWithFloat:fromRadius];
            
            return cornerRadiusAction;
        }
    }
    
    return action;
}*/

@end
