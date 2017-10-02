//
//  BlazeTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeRow.h"
#import "BlazeMediaData.h"

@interface BlazeTableViewCell : UITableViewCell
{
    
}

//Methods to override
-(void)updateCell;
-(void)willDisappear;

//Callbacks
@property(nonatomic,copy) void (^nextField)(void);
@property(nonatomic,copy) void (^previousField)(void);
@property(nonatomic,copy) void (^heightUpdated)(void);

//Next/Previous field
-(UIToolbar *)defaultInputAccessoryViewToolbar;
-(IBAction)doneField:(UIBarButtonItem *)sender;
-(IBAction)nextField:(UIBarButtonItem *)sender;
-(IBAction)previousField:(UIBarButtonItem *)sender;

//ImageView methods
-(void)updateImageView:(UIImageView *)imageView imageData:(NSData *)imageData;
-(void)updateImageView:(UIImageView *)imageView imageName:(NSString *)imageName;
-(void)updateImageView:(UIImageView *)imageView imageURLString:(NSString *)imageURLString;
-(void)updateImageView:(UIImageView *)imageView blazeMediaData:(BlazeMediaData *)mediaData;

//Properties
@property(nonatomic,strong) BlazeRow *row;
@property(nonatomic,strong) NSBundle *bundle;

//Field Processors
@property(nonatomic,strong) NSMutableArray *fieldProcessors;

//Fields
@property(nonatomic,weak) IBOutlet id mainField;
@property(nonatomic,strong) IBOutletCollection(id) NSArray *additionalFields;

//Labels
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subtitleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subsubtitleLabel;
@property(nonatomic,strong) IBOutletCollection(id) NSArray *additionalLabels;

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
@property(nonatomic,weak) IBOutlet UIView *selectedView;

//Constraints
@property(nonatomic,strong) IBOutletCollection(id) NSArray *constraints;

//PageControl
@property(nonatomic,weak) IBOutlet UIPageControl *pageControl;

@end
