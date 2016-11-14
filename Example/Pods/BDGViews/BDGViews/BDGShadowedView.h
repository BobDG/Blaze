//
//  BDGShadowedView.h
//  GraafICT
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BDGShadowedView : UIView
{
    
}

@property(nonatomic) IBInspectable float shadowRadius;
@property(nonatomic) IBInspectable float shadowOpacity;
@property(nonatomic) IBInspectable CGSize shadowOffset;
@property(nonatomic) IBInspectable UIColor *shadowColor;

@end
