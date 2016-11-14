//
//  BDGDashedLineView.h
//  GraafICT
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BDGDashedLineView : UIView
{
    
}

@property(nonatomic) IBInspectable UIColor *color;
@property(nonatomic) IBInspectable float thickness;
@property(nonatomic) IBInspectable float dashedGap;
@property(nonatomic) IBInspectable float dashedLength;

@end
