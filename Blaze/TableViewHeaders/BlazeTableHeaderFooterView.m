//
//  BlazeTableHeaderView.m
//  Blaze
//
//  Created by Bob de Graaf on 25-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BlazeTableHeaderFooterView.h"

@implementation BlazeTableHeaderFooterView

-(void)update
{
    //To override
}

-(void)willCollapse:(BOOL)collapse
{
    //To override
}

-(void)setSection:(BlazeSection *)section
{
    _section = section;
    
    //TitleLabel IF connected
    if(self.titleLabel) {
        if(self.sectionType == SectionHeader) {
            self.titleLabel.text = section.headerTitle;
            self.subtitleLabel.text = section.headerSubtitle;
        }
        else if(self.sectionType == SectionFooter) {
            self.titleLabel.text = section.footerTitle;
            self.subtitleLabel.text = section.footerSubtitle;
        }
    }
    
    //View IF connected
    if(self.view) {
        if(section.viewColor) {
            self.view.backgroundColor = section.viewColor;
        }
    }
    
    //Button IF connected
    if(self.button) {
        //Title
        if(self.section.buttonTitle) {
            [self.button setTitle:self.section.buttonTitle forState:UIControlStateNormal];
        }
        //Target
        [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //Collapse action IF callback set AND button set
    if(self.section.collapseTapped && self.collapseButton) {
        [self.collapseButton addTarget:self action:@selector(collapse:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //BackgroundColor
    if(section.backgroundColor) {
        self.contentView.backgroundColor = section.backgroundColor;
    }
    
    //Update (for subclasses)
    [self update];
}

-(IBAction)buttonTapped:(id)sender
{
    if(self.section.buttonTapped) {
        self.section.buttonTapped();
    }
}

-(IBAction)collapse:(id)sender
{
    [self willCollapse:!self.section.collapsed];
    if(self.section.collapseTapped) {
        self.section.collapseTapped();
    }
}

//It's ridiculous, but the following code fixes many autolayout constraint warnings that shouldn't be there - Apple weirdness..

-(void)setFrame:(CGRect)frame
{
    if(frame.size.width == 0) {
        return;
    }
    [super setFrame:frame];
}


@end
