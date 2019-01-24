//
//  BDGTabsView.h
//  GraafICT
//
//  Created by Bob de Graaf on 16-03-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGTabsView : UIView
{
    
}

//Styling
@property(nonatomic) bool centered;
@property(nonatomic) bool upperCase;
@property(nonatomic) bool fillBackground;
@property(nonatomic) bool disableScrolling;
@property(nonatomic) bool lineWidthExcludesPadding;
@property(nonatomic) int cornerRadius;
@property(nonatomic) float lineHeight;
@property(nonatomic) float paddingSides;
@property(nonatomic) float paddingBetween;
@property(nonatomic,strong) UIFont *tagFont;
@property(nonatomic,strong) UIColor *lineColor;
@property(nonatomic,strong) UIColor *activeColor;
@property(nonatomic,strong) UIColor *inactiveColor;

//Content
@property(nonatomic,strong) id activeTag;
@property(nonatomic,strong) NSArray *tags;
@property(nonatomic,copy) void (^tagSelected)(id tag);
@property(nonatomic,strong) NSString *tagPropertyName;

@end
