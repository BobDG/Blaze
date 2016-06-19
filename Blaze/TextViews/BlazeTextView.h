//
//  BlazeTextView.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15
//  Copyright (c) 2013 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlazeTextView : UITextView

@property(nonatomic,strong) IBInspectable NSString *placeholder;
@property(nonatomic,strong) NSAttributedString *attributedPlaceholder;
@property(nonatomic,strong) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end