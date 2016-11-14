//
//  BlazeTextField.m
//  BlazeExample
//
//  Created by Bob de Graaf on 01-11-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTextField.h"
#import "NSString+TextDirectionality.h"

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

@implementation BlazeTextField
{
    BOOL _isFloatingLabelFontDefault;
}

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
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    
    // some basic default fonts/colors
    _flFont = [self defaultFloatingLabelFont];
    _floatingLabel.font = _flFont;
    _flTextColor = [UIColor grayColor];
    _floatingLabel.textColor = _flTextColor;
    _animateEvenIfNotFirstResponder = NO;
    _floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    _floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    [self setflText:self.placeholder];
    
    _adjustsClearButtonRect = YES;
    _isFloatingLabelFontDefault = YES;
}

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self layoutSubviews];
    [self setCorrectPlaceholder:self.placeholder];
    [self updateDefaultFloatingLabelFont];
    [self setflText:self.flText];
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
    
    if (_isFloatingLabelFontDefault) {
        self.flFont = derivedFont;
    }
    else {
        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
        _flFont = derivedFont;
    }
}

-(UIColor *)labelActiveColor
{
    if (_flActiveTextColor) {
        return _flActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

-(void)setflFont:(UIFont *)flFont
{
    if (flFont != nil) {
        _flFont = flFont;
    }
    _floatingLabel.font = _flFont ? _flFont : [self defaultFloatingLabelFont];
    _isFloatingLabelFontDefault = flFont == nil;
    [self invalidateIntrinsicContentSize];
}

-(void)showFloatingLabel:(BOOL)animated
{    
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _flYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
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
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.font.lineHeight + _placeholderYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
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
        originX = textRect.origin.x + (textRect.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentNatural) {
        JVTextDirection baseDirection = [_floatingLabel.text getBaseDirection];
        if (baseDirection == JVTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
        }
    }
    
    _floatingLabel.frame = CGRectMake(originX + _floatingLabelXPadding, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

-(void)setflText:(NSString *)text
{
    _flText = text;
    _floatingLabel.text = text;
    [self setNeedsLayout];
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
    [self updateDefaultFloatingLabelFont];
}

-(CGSize)intrinsicContentSize
{
    if(!self.useFloatingLabel) {
        return [super intrinsicContentSize];
    }
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _flYPadding + _floatingLabel.bounds.size.height);
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
    [self setflText:placeholder];
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setflText:attributedPlaceholder.string];
    [self updateDefaultFloatingLabelFont];
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    if(!self.useFloatingLabel) {
        return [super textRectForBounds:bounds];
    }
    CGRect rect = [super textRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
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
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

-(CGRect)insetRectForBounds:(CGRect)rect
{
    CGFloat topInset = ceilf(_floatingLabel.bounds.size.height + _placeholderYPadding);
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
        && _floatingLabel.text.length // for when there is no floating title label text
        ) {
        if ([self.text length] || self.keepBaseline) {
            CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
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
    
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
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
    
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
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

-(void)setAlwaysShowFloatingLabel:(BOOL)alwaysShowFloatingLabel
{
    _alwaysShowFloatingLabel = alwaysShowFloatingLabel;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!self.useFloatingLabel) {
        return;
    }
    
    [self setLabelOriginForTextAlignment];
    
    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];
    
    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);
    
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ?
                                self.labelActiveColor : self.flTextColor);
    if ((!self.text || 0 == [self.text length]) && !self.alwaysShowFloatingLabel) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
}

@end









