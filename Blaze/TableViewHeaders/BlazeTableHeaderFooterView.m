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
    
}

-(void)setSection:(BlazeSection *)section
{
    _section = section;
    
    //TitleLabel IF connected
    if(self.titleLabel) {
        if(self.sectionType == SectionHeader) {
            self.titleLabel.text = section.headerTitle;
        }
        else if(self.sectionType == SectionFooter) {
            self.titleLabel.text = section.footerTitle;
        }
    }
    
    //View IF connected
    if(self.view) {
        if(section.viewColor) {
            self.view.backgroundColor = section.viewColor;
        }
    }
    
    //BackgroundColor
    if(section.backgroundColor) {
        self.contentView.backgroundColor = section.backgroundColor;
    }
    
    //Update (for subclasses)
    [self update];
}

@end
