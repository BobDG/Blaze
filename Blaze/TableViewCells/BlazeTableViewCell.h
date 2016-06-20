//
//  BlazeTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeRow.h"

@interface BlazeTableViewCell : UITableViewCell
{
    
}

//Methods
-(void)updateCell;

//Callbacks
@property(nonatomic,copy) void (^nextField)(void);
@property(nonatomic,copy) void (^previousField)(void);
@property(nonatomic,copy) void (^heightUpdated)(void);

//Next/Previous field
-(UIToolbar *)defaultInputAccessoryViewToolbar;
-(IBAction)doneField:(UIBarButtonItem *)sender;
-(IBAction)nextField:(UIBarButtonItem *)sender;
-(IBAction)previousField:(UIBarButtonItem *)sender;

//Properties
@property(nonatomic,strong) BlazeRow *row;

//Labels
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subtitleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subsubtitleLabel;

//Buttons
@property(nonatomic,weak) IBOutlet UIButton *buttonLeft;
@property(nonatomic,weak) IBOutlet UIButton *buttonCenter;
@property(nonatomic,weak) IBOutlet UIButton *buttonRight;

//ImageViews
@property(nonatomic,weak) IBOutlet UIImageView *imageViewLeft;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewCenter;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewRight;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewBackground;

//Views
@property(nonatomic,weak) IBOutlet UIView *viewLeft;
@property(nonatomic,weak) IBOutlet UIView *viewCenter;
@property(nonatomic,weak) IBOutlet UIView *viewRight;

@end