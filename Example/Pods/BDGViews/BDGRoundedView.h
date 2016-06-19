//
//  BDGRoundedView.h
//  GraafICT
//
//  Created by Bob de Graaf on 04/02/16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BDGRoundedView : UIView


@property(nonatomic) IBInspectable int cornerRadius;
@property(nonatomic) IBInspectable BOOL topLeftCorner;
@property(nonatomic) IBInspectable BOOL topRightCorner;
@property(nonatomic) IBInspectable BOOL botRightCorner;
@property(nonatomic) IBInspectable BOOL botLeftCorner;

@end
