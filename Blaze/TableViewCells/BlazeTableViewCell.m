//
//  BlazeTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "BlazeTextField.h"
#import "BlazeTableViewCell.h"
#import "BlazeFieldProcessor.h"
#import "BlazeDatePickerField.h"
#import "BlazePickerViewField.h"
#import "BlazeDateFieldProcessor.h"
#import "BlazeTextFieldProcessor.h"
#import "BlazePickerFieldProcessor.h"
#import "BlazePickerViewMultipleField.h"
#import "BlazePickerFieldMultipleProcessor.h"

@implementation BlazeTableViewCell

#pragma mark - Awake

-(void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Selected/Highlighted

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if(selected && self.mainField && !self.row.disableEditing) {
        [self.mainField becomeFirstResponder];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    //Update selectedView if one is assigned
    if(self.selectedView) {
        self.selectedView.hidden = !highlighted;
    }
}

#pragma mark - Update

-(void)updateCell
{
    //To be overridden
}

-(void)willDisappear
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
    
    //Additional Labels
    if(self.row.additionalTitles.count > 0 && self.row.additionalTitles.count == self.additionalLabels.count) {
        for(int i = 0; i < self.row.additionalTitles.count; i++) {
            id text = self.row.additionalTitles[i];
            UILabel *label = (UILabel *)self.additionalLabels[i];
            if([text isKindOfClass:[NSAttributedString class]]) {
                label.attributedText = text;
            }
            else {
                label.text = text;
            }
        }
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
    
    //Field processors
    [self setupFieldProcessors];
    
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
        if(self.bundle) {
            imageView.image = [UIImage imageNamed:imageName inBundle:self.bundle compatibleWithTraitCollection:nil];
        } else {
            imageView.image = [UIImage imageNamed:imageName];
        }
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

-(void)updateImageView:(UIImageView *)imageView blazeMediaData:(BlazeMediaData *)mediaData
{
    if(mediaData.data) {
        [self updateImageView:imageView imageData:mediaData.data];
    }
    else if(mediaData.urlStr.length) {
        [self updateImageView:imageView imageURLString:mediaData.urlStr];
    }
    else if(mediaData.name.length) {
        [self updateImageView:imageView imageName:mediaData.name];
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
    if(!self.mainField) {
        return FALSE;
    }
    return !self.row.disableEditing;
}

-(BOOL)becomeFirstResponder
{
    NSUInteger index = [self indexForCurrentFirstResponder];
    if(index != NSNotFound) {
        BlazeFieldProcessor *processor = self.fieldProcessors[index];
        return [processor.field becomeFirstResponder];
    }
    else if(self.mainField) {
        [self.mainField becomeFirstResponder];
    }
    return FALSE;
}

#pragma mark - Next/Previous fields

-(UIToolbar *)defaultInputAccessoryViewToolbar
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *nextBB;
    UIBarButtonItem *previousBB;
    if(self.row.inputAccessoryViewType == InputAccessoryViewDefaultArrows) {
        previousBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Left" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
        nextBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Right" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    }
    else if(self.row.inputAccessoryViewType == InputAccessoryViewDefaultStrings) {
        previousBB = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Blaze_KeyboardButton_Previous", @"") style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
        nextBB = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Blaze_KeyboardButton_Next", @"") style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    }
    UIBarButtonItem *fixedSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBB.width = 20.0f;
    UIBarButtonItem *flexibleSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneField:)];
    [toolBar setItems:@[previousBB, fixedSpaceBB, nextBB, flexibleSpaceBB, doneBB]]; 
    [toolBar sizeToFit];
    return toolBar;
}

-(IBAction)doneField:(UIBarButtonItem *)sender
{
    [self endEditing:TRUE];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)nextField:(UIBarButtonItem *)sender
{
    if(self.fieldProcessors.count>1) {
        NSUInteger index = [self indexForCurrentFirstResponder];
        if(index != NSNotFound) {
            if(index+1 < self.fieldProcessors.count) {
                BlazeFieldProcessor *nextProcessor = self.fieldProcessors[index+1];
                [nextProcessor.field becomeFirstResponder];
                return;
            }
        }
    }
    if(self.nextField) {
        self.nextField();
    }
}

-(void)previousField:(UIBarButtonItem *)sender
{
    if(self.fieldProcessors.count>1) {
        NSUInteger index = [self indexForCurrentFirstResponder];
        if(index != NSNotFound) {
            if((int)index-1 >= 0) {
                BlazeFieldProcessor *nextProcessor = self.fieldProcessors[index-1];
                [nextProcessor.field becomeFirstResponder];
                return;
            }
        }
    }
    
    if(self.previousField) {
        self.previousField();
    }
}

#pragma mark - FieldProcessors

-(void)setupFieldProcessors
{
    if(!self.mainField) {
        return;
    }
    
    //Fields
    NSMutableArray *fields = [NSMutableArray new];
    [fields addObject:self.mainField];
    if(self.additionalFields.count) {
        [fields addObjectsFromArray:self.additionalFields];
    }
    
    //Rows
    NSMutableArray *rows = [NSMutableArray new];
    [rows addObject:self.row];
    [rows addObjectsFromArray:self.row.additionalRows];
    
    //Clear fieldprocessors
    [self.fieldProcessors removeAllObjects];
    
    //Always create new processors, otherwise they are reused and inherit wrong properties they might not override
    for(int i = 0; i < rows.count; i++) {
        //Index check
        if(i >= fields.count) {
            break;
        }
        
        //Field
        id field = fields[i];
        
        //Determine Processor
        BlazeFieldProcessor *processor;
        if([field isKindOfClass:[BlazeDatePickerField class]]) {
            processor = [BlazeDateFieldProcessor new];
        }
        else if([field isKindOfClass:[BlazePickerViewField class]]) {
            processor = [BlazePickerFieldProcessor new];
        }
        else if([field isKindOfClass:[BlazePickerViewMultipleField class]]) {
            processor = [BlazePickerFieldMultipleProcessor new];
        }
        else if([field isKindOfClass:[BlazeTextField class]]) {
            processor = [BlazeTextFieldProcessor new];
        }
        
        //Set processor properties
        processor.field = field;
        processor.row = rows[i];
        processor.cell = self;
        [processor update];
        
        //Add it
        [self.fieldProcessors addObject:processor];
    }
}

-(NSUInteger)indexForCurrentFirstResponder
{
    for(int i = 0; i < self.fieldProcessors.count; i++) {
        BlazeFieldProcessor *processor = self.fieldProcessors[i];
        if([processor.field isFirstResponder]) {
            return i;
        }
    }
    return NSNotFound;
}

-(NSMutableArray *)fieldProcessors
{
    if(!_fieldProcessors) {
        _fieldProcessors = [NSMutableArray new];
    }
    return _fieldProcessors;
}

@end
