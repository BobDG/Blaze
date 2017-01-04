//
//  BlazeTableHeaderView.h
//  Blaze
//
//  Created by Bob de Graaf on 25-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeSection.h"

typedef NS_ENUM(NSInteger, SectionType) {
    SectionHeader,
    SectionFooter,
};

@interface BlazeTableHeaderFooterView : UITableViewHeaderFooterView
{
    
}

//Methods to override
-(void)update;
-(void)willCollapse:(BOOL)collapse;

//Properties
@property(nonatomic) SectionType sectionType;
@property(nonatomic,strong) BlazeSection *section;

//Outlets
@property(nonatomic,weak) IBOutlet UIView *view;
@property(nonatomic,weak) IBOutlet UIButton *button;
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subtitleLabel;
@property(nonatomic,weak) IBOutlet UIButton *collapseButton;
@property(nonatomic,weak) IBOutlet UIImageView *backgroundImageView;

@end
