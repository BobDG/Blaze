//
//  BlazeSliderTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeSliderTableViewCell.h"

@interface BlazeSliderTableViewCell ()
{
    
}

@property(nonatomic,weak) IBOutlet UISlider *slider;
@property(nonatomic,weak) IBOutlet UILabel *leftLabel;
@property(nonatomic,weak) IBOutlet UILabel *centerLabel;
@property(nonatomic,weak) IBOutlet UILabel *rightLabel;
@property(nonatomic,weak) IBOutlet UIImageView *sliderBackgroundImageView;

@end

@implementation BlazeSliderTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(sliderDone:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateCell
{
    //Labels
    if(self.row.sliderLeftText.length) {
        self.leftLabel.text = self.row.sliderLeftText;
    }
    if(self.row.sliderCenterText.length) {
        self.centerLabel.text = self.row.sliderCenterText;
    }
    else {
        self.centerLabel.text = @"";
    }
    if(self.row.sliderRightText.length) {
        self.rightLabel.text = self.row.sliderRightText;
    }
    
    //Image
    if(self.row.sliderBackgroundImageName.length) {
        self.sliderBackgroundImageView.image = [UIImage imageNamed:self.row.sliderBackgroundImageName];
    }
    
    //Slider
    self.slider.minimumValue = self.row.sliderMin;
    self.slider.maximumValue = self.row.sliderMax;
    self.slider.value = [self.row.value floatValue];
    
    //Editable
    self.slider.userInteractionEnabled = !self.row.disableEditing;
}

-(IBAction)sliderChanged:(id)sender
{
    self.row.value = @(self.slider.value);
    [self.row updatedValue:self.row.value];
}

-(IBAction)sliderDone:(id)sender
{
    self.row.value = @(self.slider.value);
    [self.row didUpdateValue:self.row.value];
}

@end


















