//
//  BlazeTextFieldTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTextFieldTableViewCell.h"

@interface BlazeTextFieldTableViewCell () <UITextFieldDelegate>
{
    
}

@property(nonatomic) bool setupInputView;

@end

@implementation BlazeTextFieldTableViewCell

-(void)updateCell
{
    self.textField.text = self.row.value;
    self.textField.placeholder = self.row.placeholder;
    self.textField.keyboardType = self.row.keyboardType;
    self.textField.secureTextEntry = self.row.secureTextEntry;
    self.textField.autocapitalizationType = self.row.capitalizationType;
    
    if(self.row.placeholder.length && self.row.placeholderColor) {
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    
    //Editable
    self.textField.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.textField.delegate = self;
    
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
    self.textField.inputAccessoryView = toolBar;
}

-(void)done
{
    [self.textField resignFirstResponder];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.row.value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(self.row.formatter) {
        self.row.value = [self.row.formatter stringForObjectValue:self.row.value];
        textField.text = self.row.value;
        [self.row updatedValue:self.row.value];
        return FALSE;
    }
    [self.row updatedValue:self.row.value];
    return TRUE;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
    if(self.nextField) {
        self.nextField();
    }
    else {
        [textField resignFirstResponder];
    }
    return TRUE;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.textField.userInteractionEnabled) {
        [self.textField becomeFirstResponder];
    }
}

#pragma mark - FirstResponder

-(BOOL)canBecomeFirstResponder
{
    return TRUE;
}

-(BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

@end







