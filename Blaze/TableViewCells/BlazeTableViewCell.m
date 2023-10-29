//
//  BlazeTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTextView.h"
#import "BlazeTextField.h"
#import "BlazeTableViewCell.h"
#import "BlazeInputProcessor.h"
#import "BlazeDatePickerField.h"
#import "BlazePickerViewField.h"
#import "BlazeSwitchProcessor.h"
#import "BlazeTextViewProcessor.h"
#import "BlazeDateFieldProcessor.h"
#import "BlazeTextFieldProcessor.h"
#import "BlazePickerFieldProcessor.h"
#import "BlazePickerViewMultipleField.h"
#import "BlazePickerFieldMultipleProcessor.h"

#import "UIImageView+Download.h"

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

    if(selected && self.mainField && !self.row.disableEditing && !self.row.disableFirstResponderOnCellTap) {
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
        [self updateLabel:self.titleLabel withText:self.row.title attributedText:self.row.attributedTitle color:self.row.titleColor alignment:self.row.textAlignmentType font:self.row.titleFont];
    }
    if(self.subtitleLabel) {
        [self updateLabel:self.subtitleLabel withText:self.row.subtitle attributedText:self.row.attributedSubtitle color:self.row.subtitleColor alignment:self.row.textAlignmentType font:self.row.titleFont];
    }
    if(self.subsubtitleLabel) {
        [self updateLabel:self.subsubtitleLabel withText:self.row.subsubtitle attributedText:self.row.attributedSubSubtitle color:self.row.subsubtitleColor alignment:self.row.textAlignmentType font:self.row.titleFont];
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
        [self updateImageView:self.imageViewLeft withData:self.row.imageDataLeft imageURLString:self.row.imageURLStringLeft imageName:self.row.imageNameLeft imageSystemName:self.row.imageSystemNameLeft contentMode:self.row.contentModeLeft renderingMode:self.row.imageRenderModeLeft tintColor:self.row.imageTintColorLeft];
    }
    if(self.imageViewCenter) {
        [self updateImageView:self.imageViewCenter withData:self.row.imageDataCenter imageURLString:self.row.imageURLStringCenter imageName:self.row.imageNameCenter imageSystemName:self.row.imageSystemNameCenter contentMode:self.row.contentModeCenter renderingMode:self.row.imageRenderModeCenter tintColor:self.row.imageTintColorCenter];
    }
    if(self.imageViewRight) {
        [self updateImageView:self.imageViewRight withData:self.row.imageDataRight imageURLString:self.row.imageURLStringRight imageName:self.row.imageNameRight imageSystemName:self.row.imageSystemNameRight contentMode:self.row.contentModeRight renderingMode:self.row.imageRenderModeRight tintColor:self.row.imageTintColorRight];
    }
    if(self.imageViewBackground) {
        [self updateImageView:self.imageViewBackground withData:self.row.imageDataBackground imageURLString:self.row.imageURLStringBackground imageName:self.row.imageNameBackground imageSystemName:self.row.imageSystemNameBackground contentMode:self.row.contentModeBackground renderingMode:self.row.imageRenderModeBackground tintColor:self.row.imageTintColorBackground];
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
    
    //Update constraints IF available
    if(self.constraints.count && self.row.constraintConstants.count && self.constraints.count == self.row.constraintConstants.count) {
        for(int i = 0; i < self.constraints.count; i++) {
            ((NSLayoutConstraint *)self.constraints[i]).constant = [self.row.constraintConstants[i] intValue];
        }
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }
    
    //Input processors
    [self setupInputProcessors];
    
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

-(void)updateLabel:(UILabel *)label withText:(NSString *)text attributedText:(NSAttributedString *)attributedText color:(UIColor *)color alignment:(NSNumber *)alignment font:(UIFont *)font
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
    
    //Font
    if(font) {
        label.font = font;
    }
    
    //Alignment
    if(alignment) {
        label.textAlignment = (NSTextAlignment)[alignment intValue];
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
        [imageView setImageWithURLString:imageURLString placeholderImage:[UIImage new]];
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

-(void)updateImageView:(UIImageView *)imageView withData:(NSData *)imageData imageURLString:(NSString *)imageURLString imageName:(NSString *)imageName imageSystemName:(NSString *)imageSystemName contentMode:(UIViewContentMode)contentMode renderingMode:(UIImageRenderingMode)renderingMode tintColor:(UIColor *)tintColor
{
    if(imageData) {
        imageView.image = [UIImage imageWithData:imageData];
    }
    else if(imageURLString.length) {
        [imageView setImageWithURLString:imageURLString placeholderImage:[UIImage new]];
    }
    else if(imageName.length) {
        if(self.bundle) {
            imageView.image = [UIImage imageNamed:imageName inBundle:self.bundle compatibleWithTraitCollection:nil];
        } else {
            imageView.image = [UIImage imageNamed:imageName];
        }
    }
    else if(imageSystemName.length) {
        imageView.image = [UIImage systemImageNamed:imageSystemName];
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
    if(!self.mainField || [self.mainField isKindOfClass:[UISwitch class]]) {
        return FALSE;
    }
    return !self.row.disableEditing;
}

-(BOOL)becomeFirstResponder
{
    NSUInteger index = [self indexForCurrentFirstResponder];
    if(index != NSNotFound) {
        BlazeInputProcessor *processor = self.inputProcessors[index];
        return [processor.input becomeFirstResponder];
    }
    else if(self.mainField) {
        [self.mainField becomeFirstResponder];
    }
    return FALSE;
}

#pragma mark - Next/Previous fields

-(UIView *)defaultInputAccessoryView
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *nextBB;
    UIBarButtonItem *previousBB;
    if(self.row.inputAccessoryViewType == InputAccessoryViewArrowsLeftRight) {
        previousBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Left" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
        nextBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Right" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    }
    else if(self.row.inputAccessoryViewType == InputAccessoryViewArrowsUpDown) {
        previousBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Up" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
        nextBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Down" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    }
    else if(self.row.inputAccessoryViewType == InputAccessoryViewStrings) {
        previousBB = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Blaze_KeyboardButton_Previous", @"") style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)];
        nextBB = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Blaze_KeyboardButton_Next", @"") style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)];
    }
    UIBarButtonItem *fixedSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBB.width = 20.0f;
    UIBarButtonItem *flexibleSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneField:)];
    [toolBar setItems:@[previousBB, fixedSpaceBB, nextBB, flexibleSpaceBB, doneBB]]; 
    [toolBar sizeToFit];
    
    //In case of a special additional accessoryview button
    if(self.row.inputAccessoryButton) {
        UIView *returnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolBar.frame.size.width, toolBar.frame.size.height*2)];
        UIButton *button = [[UIButton alloc] initWithFrame:toolBar.bounds];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        if(self.row.inputAccessoryButtonColor) {
            button.backgroundColor = self.row.inputAccessoryButtonColor;
        }
        [button setAttributedTitle:self.row.inputAccessoryButtonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(accessoryButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [returnView addSubview:button];
        toolBar.frame = CGRectMake(0, toolBar.frame.size.height, toolBar.frame.size.width, toolBar.frame.size.height);
        [returnView addSubview:toolBar];        
        return returnView;
    }
    
    return toolBar;
}

-(IBAction)doneField:(UIBarButtonItem *)sender
{
    [self endEditing:TRUE];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)accessoryButtonTapped
{
    if(self.row.inputAccessoryButtonTapped) {
        self.row.inputAccessoryButtonTapped();
    }
}

-(void)nextField:(UIBarButtonItem *)sender
{
    if(self.inputProcessors.count>1) {
        NSUInteger index = [self indexForCurrentFirstResponder];
        if(index != NSNotFound) {
            for(int i = (int)index+1; i < self.inputProcessors.count; i++) {
                BlazeInputProcessor *nextProcessor = self.inputProcessors[i];
                if(nextProcessor.canBecomeFirstResponder) {
                    [nextProcessor.input becomeFirstResponder];
                    return;
                }
            }
        }
    }
    if(self.nextField) {
        self.nextField();
    }
}

-(void)previousField:(UIBarButtonItem *)sender
{
    if(self.inputProcessors.count>1) {
        NSUInteger index = [self indexForCurrentFirstResponder];
        if(index != NSNotFound) {
            for(int i = (int)index -1; i >= 0; i--) {
                BlazeInputProcessor *nextProcessor = self.inputProcessors[i];
                if(nextProcessor.canBecomeFirstResponder) {
                    [nextProcessor.input becomeFirstResponder];
                    return;
                }
            }
        }
    }
    
    if(self.previousField) {
        self.previousField();
    }
}

#pragma mark - InputProcessors

-(void)setupInputProcessors
{
    //Inputs
    NSMutableArray *rows = [NSMutableArray new];
    NSMutableArray *inputs = [NSMutableArray new];
    if(self.mainField) {
        [rows addObject:self.row];
        [inputs addObject:self.mainField];
    }
    if(self.additionalFields.count) {
        [inputs addObjectsFromArray:self.additionalFields];
        if(self.row.additionalRows.count) {
            [rows addObjectsFromArray:self.row.additionalRows];
        }
    }
    
    //Got any?
    if(!inputs.count) {
        return;
    }
    
    //Clear fieldprocessors
    [self.inputProcessors removeAllObjects];
    
    //Always create new processors, otherwise they are reused and inherit wrong properties they might not override
    for(int i = 0; i < rows.count; i++) {
        //Index check
        if(i >= inputs.count) {
            break;
        }
        
        //Input
        id input = inputs[i];
        
        //Determine Processor
        BlazeInputProcessor *processor;
        if([input isMemberOfClass:[BlazeTextField class]]) {
            processor = [BlazeTextFieldProcessor new];
        }
        else if([input isMemberOfClass:[BlazeDatePickerField class]]) {
            processor = [BlazeDateFieldProcessor new];
        }
        else if([input isMemberOfClass:[BlazePickerViewField class]]) {
            processor = [BlazePickerFieldProcessor new];
        }
        else if([input isMemberOfClass:[UISwitch class]]) {
            processor = [BlazeSwitchProcessor new];
        }
        else if([input isMemberOfClass:[BlazeTextView class]]) {
            processor = [BlazeTextViewProcessor new];
        }
        else if([input isMemberOfClass:[BlazePickerViewMultipleField class]]) {
            processor = [BlazePickerFieldMultipleProcessor new];
        }
        
        //Set processor properties
        processor.input = input;
        processor.row = rows[i];
        processor.cell = self;
        [processor update];
        
        //Add it
        [self.inputProcessors addObject:processor];
    }
}

-(NSUInteger)indexForCurrentFirstResponder
{
    for(int i = 0; i < self.inputProcessors.count; i++) {
        BlazeInputProcessor *processor = self.inputProcessors[i];
        if([processor.input isFirstResponder]) {
            return i;
        }
    }
    return NSNotFound;
}

-(NSMutableArray *)inputProcessors
{
    if(!_inputProcessors) {
        _inputProcessors = [NSMutableArray new];
    }
    return _inputProcessors;
}

@end
