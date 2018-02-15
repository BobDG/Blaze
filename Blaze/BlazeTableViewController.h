//
//  BlazeTableViewController.h
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeRow.h"
#import "BlazeSection.h"
#import "BlazeTableViewCell.h"
#import "NSObject+PropertyName.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BlazeTableViewController : UITableViewController
{
    
}

//Optional Xibname for all rows/headers/footers in case they're all the same
@property(nonatomic,strong) NSString *rowsXibName;
@property(nonatomic,strong) NSString *headerXibName;
@property(nonatomic,strong) NSString *footerXibName;

//Empty set variables
@property(nonatomic) bool emptyScrollable;
@property(nonatomic) float emptyVerticalOffset;
@property(nonatomic,strong) UIImage *emptyImage;
@property(nonatomic,strong) NSString *emptyTitle;
@property(nonatomic,strong) NSAttributedString *emptyAttributedTitle;
@property(nonatomic,strong) UIColor *emptyBackgroundColor;
@property(nonatomic,strong) NSDictionary *emptyTitleAttributes;
@property(nonatomic,strong) UIView *emptyCustomView;
@property(nonatomic,strong) NSNumber *emptyVerticalTopPadding;
@property(nonatomic,strong) NSNumber *filledTableViewCellSeparatorStyle;
@property(nonatomic,strong) NSNumber *emptyTableViewCellSeparatorStyle;

//Default InputAccessoryView
@property(nonatomic,strong) NSNumber *defaultInputAccessoryViewType;

//Specific bundle for nibs
@property(nonatomic,strong) NSBundle *bundle;

//Section index picker (A-Z) - Implemented assuming sections are correctly formatted and have a unique first-letter
@property(nonatomic) bool useSectionIndexPicker;

//Separator Inset
@property(nonatomic) bool noSeparatorInset;

//Disappearing - notify cells to for example stop timers/video's playing, etc.
@property(nonatomic) bool notifyCellsWhenDisappearing;

//Header caching (for animations in headerviews)
-(void)clearSectionHeaderCache;
@property(nonatomic) bool sectionHeaderCaching;

//Inverted tableview (and cells/emptyview) - useful when showing e.g. messages from bottom to top incl. refreshcontrol at the bottom
@property(nonatomic) bool invertedTableView;

//Heights
@property(nonatomic,strong) NSNumber *rowHeight;
@property(nonatomic,strong) NSNumber *estimatedRowHeight;
@property(nonatomic,strong) NSNumber *sectionHeaderHeight;
@property(nonatomic,strong) NSNumber *sectionFooterHeight;

//Load content on appear
-(void)loadTableContent;
@property(nonatomic) bool loadContentOnAppear;

//TableArray
@property(nonatomic,strong) NSMutableArray <BlazeSection *> *tableArray;

//DraggableZoom headerView
@property(nonatomic,strong) UIView *zoomTableHeaderView;

//Parallax effect HeaderView
@property(nonatomic) float headerParallaxScrollRatio;

//Refreshcontrol
-(void)endRefreshing;
@property(nonatomic) bool enableRefreshControl;
@property(nonatomic,copy) void (^refreshControlPulled)(void);

//Scrolling
@property(nonatomic,copy) void (^beganScrolling)(void);

//Floating Action Button - Advise is to setup in viewdidappear to ensure correct frame and visible animation
-(void)removeFloatingActionButton;
-(void)setupFloatingActionButtonWithImage:(UIImage *)image padding:(float)padding tapped:(void (^)(void))tapped;
-(void)setupFloatingActionButtonWithImage:(UIImage *)image padding:(float)padding tapped:(void (^)(void))tapped animated:(BOOL)animated;

//Collapsing - override for example to fix iOS9 crashes...
-(void)collapseSection:(int)sectionIndex;

//Scrolling
-(void)scrollToTop:(BOOL)animated;

//Registering
-(void)registerCustomCell:(NSString *)xibName;
-(void)registerCustomHeader:(NSString *)xibName;
-(void)registerCustomCells:(NSArray <NSString *> *)cellNames;
-(void)registerCustomHeaders:(NSArray <NSString *> *)headerNames;

//Retrieving
-(BlazeRow *)rowForID:(int)rowID;
-(NSIndexPath *)indexPathForRowID:(int)rowID;
-(BlazeSection *)sectionForID:(int)sectionID;
-(NSIndexPath *)indexPathForRow:(BlazeRow *)row;
-(BlazeTableViewCell *)cellForRow:(BlazeRow *)row;
-(BlazeRow *)rowForIndexPath:(NSIndexPath *)indexPath;

//Reloading
-(void)reloadHeightsQuickly;
-(void)reloadTable:(BOOL)animated;
-(void)reloadCellForID:(int)rowID;
-(void)reloadTableWithFadeTransition;
-(void)reloadCellForRow:(BlazeRow *)row;
-(void)reloadTableWithAnimation:(UITableViewRowAnimation)animation;
-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadCellForRow:(BlazeRow *)row withRowAnimation:(UITableViewRowAnimation)animation;

//Adding sections
-(void)addSection:(BlazeSection *)section;
-(void)addSection:(BlazeSection *)section afterSectionID:(int)afterSectionID;

//Deleting rows
-(void)deleteRow:(BlazeRow *)row;
-(void)deleteRows:(NSArray *)rows;
-(void)deleteRow:(BlazeRow *)row withRowAnimation:(UITableViewRowAnimation)animation;
-(void)deleteRows:(NSArray *)rows withRowAnimation:(UITableViewRowAnimation)animation;

//Adding rows
-(void)addRows:(NSArray *)rows atIndexPaths:(NSArray *)indexPaths;
-(void)addRow:(BlazeRow *)row atIndexPath:(NSIndexPath *)indexPath;
-(void)addRows:(NSArray *)rows atIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
-(void)addRow:(BlazeRow *)row atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

//Adding rows with older ID methods
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID;
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID withRowAnimation:(UITableViewRowAnimation)animation;

//Removing sections
-(void)removeSectionWithID:(int)sectionID;

//Removing rows
-(void)removeRowWithID:(int)rowID;
-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex;
-(void)removeRowWithID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;

@end























