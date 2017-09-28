//
//  BDGCircularProgressView.h
//
//  Created by Bob de Graaf on 27-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGCircularProgressView : UIView
{
    
}

@property(nonatomic,strong) UIColor *trackColor;
@property(nonatomic,strong) UIColor *fullPathTrackColor;
@property(nonatomic,strong) UIColor *fullPathFillColor;
@property(nonatomic) float animationDuration;

-(void)animateProgress:(float)progress fromProgress:(float)fromProgress;
-(void)setupRainbowViewWithColors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations;

@end
