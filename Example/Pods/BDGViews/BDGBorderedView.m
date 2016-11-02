//
//  BDGBorderedView.m
//  GraafICT
//
//  Created by Bob de Graaf on 23-12-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGBorderedView.h"

@implementation BDGBorderedView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) {
        return nil;
    }
    
    self.opaque = NO;
    self.clipsToBounds = TRUE;
    
    return self;
}

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

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //IBInspectables
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
}

@end
