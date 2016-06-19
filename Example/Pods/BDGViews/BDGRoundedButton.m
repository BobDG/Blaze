//
//  BDGRoundedButton.m
//  GraafICT
//
//  Created by Bob de Graaf on 16-12-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGRoundedButton.h"

@implementation BDGRoundedButton

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Circular properties
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
