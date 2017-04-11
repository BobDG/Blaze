//
//  BlazeTableTextViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextViewTableViewCell.h"

@interface BlazeTextViewTableViewCell () <UITextViewDelegate>
{
    
}

@property(nonatomic) float previousHeight;
@property(nonatomic) float preferredHeightOneLine;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation BlazeTextViewTableViewCell

-(void)updateCell
{
    //Text
    self.textView.text = self.row.value;
    
    if(self.row.attributedPlaceholder.length) {
        self.textView.attributedPlaceholder = self.row.attributedPlaceholder;
    }
    else if(self.row.placeholder.length && self.row.placeholderColor) {
        self.textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.row.placeholder attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    else if(self.row.placeholder.length) {
        self.textView.placeholder = self.row.placeholder;
    }
    
    //Editable
    self.textView.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.textView.delegate = self;
    
    //Scrolling
    self.textView.scrollsToTop = FALSE;
    self.textView.scrollEnabled = FALSE;
    
    //Set constant
    self.previousHeight = self.textViewHeightConstraint.constant;
    self.preferredHeightOneLine = self.previousHeight;
    
    //AccessoryInputView
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    NSMutableArray *barbuttonItemsArray = [NSMutableArray new];
    [barbuttonItemsArray addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Left" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(previousField:)]];
    UIBarButtonItem *fixedSpaceBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBB.width = 20.0f;
    [barbuttonItemsArray addObject:fixedSpaceBB];
    [barbuttonItemsArray addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Arrow_Right" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(nextField:)]];
    [barbuttonItemsArray addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [barbuttonItemsArray addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)]];
    [toolBar setItems:barbuttonItemsArray];
    [toolBar sizeToFit];
    self.textView.inputAccessoryView = toolBar;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.textView.userInteractionEnabled) {
        [self.textView becomeFirstResponder];
    }
}

-(void)done
{
    [self.textView resignFirstResponder];    
}

#pragma mark - UITextViewDelegate

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    //Set height constraint
    float heightThatFitsTextView = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)].height;
    float newConstant;
    if(heightThatFitsTextView>self.preferredHeightOneLine) {
        newConstant = heightThatFitsTextView;
    }
    else {
        newConstant = self.preferredHeightOneLine;
    }
    if(newConstant != self.previousHeight) {
        self.textViewHeightConstraint.constant = newConstant;
        self.previousHeight = newConstant;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        
        if(self.heightUpdated) {
            self.heightUpdated();
        }
    }
    
    self.row.value = textView.text;
    [self.row updatedValue:self.row.value];
}
#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return self.textView.userInteractionEnabled;
}

-(BOOL)becomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}


@end






























