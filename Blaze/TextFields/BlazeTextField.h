//
//  BlazeTextField.h
//  BlazeExample
//
//  Created by Bob de Graaf on 01-11-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlazeRow;

IB_DESIGNABLE

@interface BlazeTextField : UITextField
{
    
}

/**
 Use floating title-label
 */
@property(nonatomic) IBInspectable BOOL useFloatingLabel;

/**
 * Read-only access to the floating label.
 */
@property(nonatomic,strong,readonly) UILabel *floatingLabel;

/**
 * Padding to be applied to the y coordinate of the floating label upon presentation.
 * Defaults to zero.
 */
@property(nonatomic) IBInspectable CGFloat flYPadding;

/**
 * Padding to be applied to the x coordinate of the floating label upon presentation.
 * Defaults to zero
 */
@property(nonatomic) CGFloat floatingLabelXPadding;

/**
 * Padding to be applied to the y coordinate of the placeholder.
 * Defaults to zero.
 */
@property(nonatomic) CGFloat placeholderYPadding;

/**
 * Font to be applied to the floating label.
 * Defaults to the first applicable of the following:
 * - the custom specified attributed placeholder font at 70% of its size
 * - the custom specified textField font at 70% of its size
 */
@property(nonatomic,strong) UIFont *flFont;

/** 
 * Text for the floating label
 */

@property(nonatomic,strong) IBInspectable NSString *flText;

/**
 * Text color to be applied to the floating label.
 * Defaults to `[UIColor grayColor]`.
 */
@property(nonatomic,strong) IBInspectable UIColor *flTextColor;

/**
 * Text color to be applied to the floating label while the field is a first responder.
 * Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
 */
@property(nonatomic,strong) IBInspectable UIColor *flActiveTextColor;

/**
 * Indicates whether the floating label's appearance should be animated regardless of first responder status.
 * By default, animation only occurs if the text field is a first responder.
 */
@property(nonatomic,assign) BOOL animateEvenIfNotFirstResponder;

/**
 * Duration of the animation when showing the floating label.
 * Defaults to 0.3 seconds.
 */
@property(nonatomic,assign) NSTimeInterval floatingLabelShowAnimationDuration;

/**
 * Duration of the animation when hiding the floating label.
 * Defaults to 0.3 seconds.
 */
@property(nonatomic,assign) NSTimeInterval floatingLabelHideAnimationDuration;

/**
 * Indicates whether the clearButton position is adjusted to align with the text
 * Defaults to 1.
 */
@property(nonatomic,assign) BOOL adjustsClearButtonRect;

/**
 * Indicates whether or not to drop the baseline when entering text. Setting to YES (not the default) means the standard greyed-out placeholder will be aligned with the entered text
 * Defaults to NO (standard placeholder will be above whatever text is entered)
 */
@property(nonatomic,assign) IBInspectable BOOL flAlterBaseline;

/**
 * Force floating label to be always visible
 * Defaults to NO
 */
@property(nonatomic,assign) IBInspectable BOOL flAlwaysShow;

/**
 * Color of the placeholder
 */
@property(nonatomic,strong) IBInspectable UIColor *placeholderColor;


/**
 Merge the configuration on a BlazeRow object with IBInspectables

 @param row The BlazeRow that configures this BlazeRowTextField
 */
-(void)mergeBlazeRowWithInspectables:(BlazeRow *)row;

@end
