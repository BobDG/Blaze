//
//  BlazeTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "BlazeTableViewCell.h"

@implementation BlazeTableViewCell

#pragma mark - Awake

-(void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Selected

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Update

-(void)updateCell
{
    //To be overridden
}

-(void)setRow:(BlazeRow *)row
{
    _row = row;
    
    //Update Labels IF connected
    if(self.titleLabel) {
        [self updateLabel:self.titleLabel withText:self.row.title attributedText:self.row.attributedTitle color:self.row.titleColor];
    }
    if(self.subtitleLabel) {
        [self updateLabel:self.subtitleLabel withText:self.row.subtitle attributedText:self.row.attributedSubtitle color:self.row.subtitleColor];
    }
    if(self.subsubtitleLabel) {
        [self updateLabel:self.subsubtitleLabel withText:self.row.subsubtitle attributedText:self.row.attributedSubSubtitle color:self.row.subsubtitleColor];
    }
    
    //Update imageviews IF connected
    if(self.imageViewLeft) {
        [self updateImageView:self.imageViewLeft withData:self.row.imageDataLeft imageURLString:self.row.imageURLStringLeft imageName:self.row.imageNameLeft contentMode:self.row.contentModeLeft renderingMode:self.row.imageRenderModeLeft tintColor:self.row.imageTintColorLeft];
    }
    if(self.imageViewCenter) {
        [self updateImageView:self.imageViewCenter withData:self.row.imageDataCenter imageURLString:self.row.imageURLStringCenter imageName:self.row.imageNameCenter contentMode:self.row.contentModeCenter renderingMode:self.row.imageRenderModeCenter tintColor:self.row.imageTintColorCenter];
    }
    if(self.imageViewRight) {
        [self updateImageView:self.imageViewRight withData:self.row.imageDataRight imageURLString:self.row.imageURLStringRight imageName:self.row.imageNameRight contentMode:self.row.contentModeRight renderingMode:self.row.imageRenderModeRight tintColor:self.row.imageTintColorRight];
    }
    if(self.imageViewBackground) {
        [self updateImageView:self.imageViewBackground withData:self.row.imageDataBackground imageURLString:self.row.imageURLStringBackground imageName:self.row.imageNameBackground contentMode:self.row.contentModeBackground renderingMode:self.row.imageRenderModeBackground tintColor:self.row.imageTintColorBackground];
    }
    
    //Update buttons IF connected
    if(self.buttonLeft) {
        [self updateButton:self.buttonLeft withText:self.row.buttonLeftTitle attributedText:self.row.buttonLeftAttributedTitle color:self.row.buttonLeftTitleColor backgroundColor:self.row.buttonLeftBackgroundColor];
        [self.buttonLeft addTarget:self action:@selector(buttonLeftTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(self.buttonCenter) {
        [self updateButton:self.buttonCenter withText:self.row.buttonCenterTitle attributedText:self.row.buttonCenterAttributedTitle color:self.row.buttonCenterTitleColor backgroundColor:self.row.buttonCenterBackgroundColor];
        [self.buttonCenter addTarget:self action:@selector(buttonCenterTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(self.buttonRight) {
        [self updateButton:self.buttonRight withText:self.row.buttonRightTitle attributedText:self.row.buttonRightAttributedTitle color:self.row.buttonRightTitleColor backgroundColor:self.row.buttonRightBackgroundColor];
        [self.buttonRight addTarget:self action:@selector(buttonRightTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //Update views IF connected
    if(self.viewLeft) {
        [self updateView:self.viewLeft backgroundColor:self.row.viewLeftBackgroundColor];
    }
    if(self.viewCenter) {
        [self updateView:self.viewCenter backgroundColor:self.row.viewCenterBackgroundColor];
    }
    if(self.viewRight) {
        [self updateView:self.viewRight backgroundColor:self.row.viewRightBackgroundColor];
    }
    
    //Update pageControl IF connected
    if(self.pageControl) {
        self.pageControl.currentPage = self.row.currentPage;
        self.pageControl.numberOfPages = self.row.numberOfPages;
    }
    
    //Update cell (for subclasses)
    [self updateCell];
}

#pragma mark - IBActions

-(IBAction)buttonLeftTapped:(id)sender
{
    if(self.row.buttonLeftTapped) {
        self.row.buttonLeftTapped();
    }
}

-(IBAction)buttonCenterTapped:(id)sender
{
    if(self.row.buttonCenterTapped) {
        self.row.buttonCenterTapped();
    }
}

-(IBAction)buttonRightTapped:(id)sender
{
    if(self.row.buttonRightTapped) {
        self.row.buttonRightTapped();
    }
}

#pragma mark - Update default UIViews

-(void)updateLabel:(UILabel *)label withText:(NSString *)text attributedText:(NSAttributedString *)attributedText color:(UIColor *)color
{
    if(attributedText.length) {
        label.attributedText = attributedText;
    }
    else if(text.length) {
        label.text = text;
    }
    else {
        label.text = @"";
    }
    
    //Color
    if(color) {
        label.textColor = color;
    }
}

-(void)updateButton:(UIButton *)button withText:(NSString *)text attributedText:(NSAttributedString *)attributedText color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor
{
    if(attributedText.length) {
        [button setAttributedTitle:attributedText forState:UIControlStateNormal];
    }
    else if(text.length) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    else {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
 
    //TitleColor
    if(color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    //BackgroundColor
    if(backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
}

#pragma mark - ImageView updates

-(void)updateImageView:(UIImageView *)imageView imageURLString:(NSString *)imageURLString
{
    if(imageURLString.length) {
        [imageView setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:[UIImage new]];
    }
    else {
        imageView.image = nil;
    }
}

-(void)updateImageView:(UIImageView *)imageView imageName:(NSString *)imageName
{
    if(imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    else {
        imageView.image = nil;
    }
}

-(void)updateImageView:(UIImageView *)imageView imageData:(NSData *)imageData
{
    if(imageData) {
        imageView.image = [UIImage imageWithData:imageData];
    }
    else {
        imageView.image = nil;
    }
}

-(void)updateImageView:(UIImageView *)imageView withData:(NSData *)imageData imageURLString:(NSString *)imageURLString imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode renderingMode:(UIImageRenderingMode)renderingMode tintColor:(UIColor *)tintColor
{
    if(imageData) {
        imageView.image = [UIImage imageWithData:imageData];
    }
    else if(imageURLString.length) {
        [imageView setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:[UIImage new]];
    }
    else if(imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    else {
        imageView.image = nil;
    }
    if(contentMode != UIViewContentModeScaleToFill) {
        imageView.contentMode = contentMode;
    }
    if(renderingMode != UIImageRenderingModeAutomatic) {
        imageView.image = [imageView.image imageWithRenderingMode:renderingMode];
    }
    if(tintColor) {
        imageView.tintColor = tintColor;
    }
}

-(void)updateView:(UIView *)view backgroundColor:(UIColor *)backgroundColor
{
    if(backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
}

#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return FALSE;
}

#pragma mark - Next/Previous fields

-(UIToolbar *)defaultInputAccessoryViewToolbar
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *previousBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Left" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
    UIBarButtonItem *fixedSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBB.width = 20.0f;
    UIBarButtonItem *nextBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Right" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    UIBarButtonItem *flexibleSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneField:)];
    [toolBar setItems:@[previousBB, fixedSpaceBB, nextBB, flexibleSpaceBB, doneBB]]; 
    [toolBar sizeToFit];
    return toolBar;
}

-(IBAction)nextField:(UIBarButtonItem *)sender
{
    if(self.nextField) {
        self.nextField();
    }
}

-(IBAction)previousField:(UIBarButtonItem *)sender
{
    if(self.previousField) {
        self.previousField();
    }
}

-(IBAction)doneField:(UIBarButtonItem *)sender
{
    [self endEditing:TRUE];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}


@end
