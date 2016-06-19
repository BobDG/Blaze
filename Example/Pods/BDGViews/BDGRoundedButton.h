//
//  BDGRoundedButton.h
//  GraafICT
//
//  Created by Bob de Graaf on 16-12-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BDGRoundedButton : UIButton
{
    
}

@property(nonatomic) IBInspectable int cornerRadius;
@property(nonatomic) IBInspectable float borderWidth;
@property(nonatomic) IBInspectable UIColor *borderColor;

@end
