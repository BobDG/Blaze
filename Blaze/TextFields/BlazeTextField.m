//
//  BlazeTextField.m
//  BlazeExample
//
//  Created by Bob de Graaf on 01-11-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"
#import "NSString+TextDirectionality.h"
#import "BlazeRow.h"

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

@interface BlazeTextField()

@property(nonatomic) BOOL isFloatingLabelFontDefault;

@end

@implementation BlazeTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    _floatingLabel = [UILabel new];
    self.floatingLabel.alpha = 0.0f;
    [self addSubview:self.floatingLabel];
    
    // some basic default fonts/colors
    self.flFont = [self defaultFloatingLabelFont];
    self.floatingLabel.font = self.flFont;
    self.floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    self.floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    self.floatingLabel.text = self.flText;
    [self setCorrectPlaceholder:self.placeholder];
    self.isFloatingLabelFontDefault = TRUE;
    self.adjustsClearButtonRect = TRUE;
    self.animateEvenIfNotFirstResponder = FALSE;
}

-(void)mergeBlazeRowWithInspectables:(BlazeRow *)row placeholder:(NSString *)placeholder attributedPlaceholder:(NSAttributedString *)attributedPlaceholder placeholderColor:(UIColor *)placeholderColor floatingTitle:(NSString *)floatingTitle
{
    //Update placholders
    if(attributedPlaceholder.length) {
        self.attributedPlaceholder = attributedPlaceholder;
    }
    else if(placeholder.length && placeholderColor) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
    }
    else if(placeholder.length) {
        self.placeholder = placeholder;
    }
    
    //Check first if it's enabled, row has preference
    if(row.floatingLabelEnabled == FloatingLabelStateUndetermined) {
        row.floatingLabelEnabled = self.useFloatingLabel;
    } else {
        self.useFloatingLabel = row.floatingLabelEnabled == FloatingLabelStateEnabled;
    }
    
    if(!self.useFloatingLabel) {
        return;
    }
    
    //Update font if applicable
    self.flFont = row.floatingTitleFont;
    
    //Update titlecolor - row has preference
    if(row.floatingTitleColor) {
        self.flTextColor = row.floatingTitleColor;
    } else if(self.flTextColor) {
        row.floatingTitleColor = self.flTextColor;
    }
    
    //Update active titlecolor - row has preference
    if(row.floatingTitleActiveColor) {
        self.flActiveTextColor = row.floatingTitleActiveColor;
    } else if(self.flActiveTextColor) {
        row.floatingTitleActiveColor = self.flActiveTextColor;
    }
    
    //Update title - row has preference
    if(floatingTitle.length) {
        self.flText = floatingTitle;
    }
    else if(self.flText.length) {
        floatingTitle = self.flText;
    }
    else if(self.placeholder.length) {
        self.flText = self.placeholder;
    }
}

-(void)mergeBlazeRowWithInspectables:(BlazeRow *)row
{
    [self mergeBlazeRowWithInspectables:row placeholder:row.placeholder attributedPlaceholder:row.attributedPlaceholder placeholderColor:row.placeholderColor floatingTitle:row.floatingTitle];
}

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self layoutSubviews];
    [self setCorrectPlaceholder:self.placeholder];
    [self updateDefaultFloatingLabelFont];
    self.floatingLabel.text = self.flText;
}

#pragma mark -

-(UIFont *)defaultFloatingLabelFont
{
    UIFont *textFieldFont = nil;
    
    if (!textFieldFont && self.attributedPlaceholder && self.attributedPlaceholder.length > 0) {
        textFieldFont = [self.attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont && self.attributedText && self.attributedText.length > 0) {
        textFieldFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont) {
        textFieldFont = self.font;
    }
    
    return [UIFont fontWithName:textFieldFont.fontName size:roundf(textFieldFont.pointSize * 0.7f)];
}

-(void)updateDefaultFloatingLabelFont
{
    UIFont *derivedFont = [self defaultFloatingLabelFont];
    
    if (self.isFloatingLabelFontDefault) {
        self.flFont = derivedFont;
    }
    else {
        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
        self.flFont = derivedFont;
    }
}

-(UIColor *)labelActiveColor
{
    if (self.flActiveTextColor) {
        return self.flActiveTextColor;
    } else if(self.flTextColor) {
        return self.flTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

-(void)setFlFont:(UIFont *)flFont
{
    if (flFont != nil) {
        _flFont = flFont;
    } else if(_flFont == flFont) {
        return;
    }
    self.floatingLabel.font = self.flFont ? self.flFont : [self defaultFloatingLabelFont];
    self.isFloatingLabelFontDefault = flFont == nil;
    [self invalidateIntrinsicContentSize];
}

-(void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        self.floatingLabel.alpha = 1.0f;
        self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x,
                                          self.flYPadding,
                                          self.floatingLabel.frame.size.width,
                                          self.floatingLabel.frame.size.height);
    };
    
    if (animated || 0 != self.animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:self.floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

-(void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        self.floatingLabel.alpha = 0.0f;
        self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x,
                                          self.floatingLabel.font.lineHeight + self.placeholderYPadding,
                                          self.floatingLabel.frame.size.width,
                                          self.floatingLabel.frame.size.height);
        
    };
    
    if (animated || 0 != self.animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:self.floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

-(void)setLabelOriginForTextAlignment
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (self.floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentNatural) {
        JVTextDirection baseDirection = [self.floatingLabel.text getBaseDirection];
        if (baseDirection == JVTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width;
        }
    }
    
    self.floatingLabel.frame = CGRectMake(originX + self.floatingLabelXPadding, self.floatingLabel.frame.origin.y,
                                      self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
}

-(void)setFlText:(NSString *)flText
{
    _flText = flText;
    self.floatingLabel.text = flText;
    [self setNeedsLayout];
}

-(void)setFlAlwaysShow:(BOOL)flAlwaysShow
{
    _flAlwaysShow = flAlwaysShow;
    [self setNeedsLayout];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setCorrectPlaceholder:self.placeholder];
}

#pragma mark - UITextField

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self updateDefaultFloatingLabelFont];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    //[self updateDefaultFloatingLabelFont];
}

-(CGSize)intrinsicContentSize
{
    if(!self.useFloatingLabel) {
        return [super intrinsicContentSize];
    }
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [self.floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + self.flYPadding + self.floatingLabel.bounds.size.height);
}

-(void)setCorrectPlaceholder:(NSString *)placeholder
{
    if (self.placeholderColor && placeholder) {
        NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                                    attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
        [super setAttributedPlaceholder:attributedPlaceholder];
    } else {
        [super setPlaceholder:placeholder];
    }
}

-(void)setPlaceholder:(NSString *)placeholder
{
    [self setCorrectPlaceholder:placeholder];
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    [super setAttributedPlaceholder:attributedPlaceholder];
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super textRectForBounds:bounds];
    }
    CGRect rect = [super textRectForBounds:bounds];
    if ([self.text length] || !self.flAlterBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super editingRectForBounds:bounds];
    }
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || !self.flAlterBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

-(CGRect)insetRectForBounds:(CGRect)rect
{
    CGFloat topInset = ceilf(self.floatingLabel.bounds.size.height + self.placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    return CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
}

-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super clearButtonRectForBounds:bounds];
    }
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (0 != self.adjustsClearButtonRect
        && self.floatingLabel.text.length // for when there is no floating title label text
        ) {
        if ([self.text length] || !self.flAlterBaseline) {
            CGFloat topInset = ceilf(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
            topInset = MIN(topInset, [self maxTopInset]);
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
        }
    }
    return CGRectIntegral(rect);
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super leftViewRectForBounds:bounds];
    }
    CGRect rect = [super leftViewRectForBounds:bounds];
    
    CGFloat topInset = ceilf(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    
    return rect;
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super rightViewRectForBounds:bounds];
    }
    CGRect rect = [super rightViewRectForBounds:bounds];
    
    CGFloat topInset = ceilf(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    
    return rect;
}

-(CGFloat)maxTopInset
{
    return MAX(0, floorf(self.bounds.size.height - self.font.lineHeight - 4.0f));
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!self.useFloatingLabel) {
        return;
    }
    
    [self setLabelOriginForTextAlignment];
    
    CGSize floatingLabelSize = [self.floatingLabel sizeThatFits:self.floatingLabel.superview.bounds.size];
    
    self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x,
                                      self.floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);
    BOOL firstResponder = self.isFirstResponder;
    self.floatingLabel.textColor = (firstResponder ?
                                self.labelActiveColor : self.flTextColor);
    if ((!self.text || 0 == [self.text length]) && !self.flAlwaysShow) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
}

@end









