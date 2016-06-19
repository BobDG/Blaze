//
//  BDGShadowedView.m
//  GraafICT
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGShadowedView.h"

@implementation BDGShadowedView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //IBInspectables
    self.layer.shadowOffset = self.shadowOffset;
    self.layer.shadowRadius = self.shadowRadius;
    self.layer.shadowOpacity = self.shadowOpacity;
    self.layer.shadowColor = self.shadowColor.CGColor;
}

@end
