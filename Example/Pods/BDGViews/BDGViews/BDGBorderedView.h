//
//  BDGBorderedView.h
//  GraafICT
//
//  Created by Bob de Graaf on 23-12-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BDGBorderedView : UIView
{
    
}

@property(nonatomic) IBInspectable float cornerRadius;
@property(nonatomic) IBInspectable float borderWidth;
@property(nonatomic) IBInspectable UIColor *borderColor;

@end
