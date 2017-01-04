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
@property(nonatomic) UITableViewCellSeparatorStyle filledTableViewCellSeparatorStyle;
@property(nonatomic) UITableViewCellSeparatorStyle emptyTableViewCellSeparatorStyle;

//Section index picker (A-Z) - Implemented assuming sections are correctly formatted and have a unique first-letter
@property(nonatomic) bool useSectionIndexPicker;

//Separator Inset
@property(nonatomic) bool noSeparatorInset;

//Heights
@property(nonatomic) float rowHeight;
@property(nonatomic) float sectionHeaderHeight;
@property(nonatomic) float sectionFooterHeight;

//Load content on appear
-(void)loadTableContent;
@property(nonatomic) bool loadContentOnAppear;

//TableArray
@property(nonatomic,strong) NSMutableArray *tableArray;

//DraggableZoom headerView
@property(nonatomic,strong) UIView *zoomTableHeaderView;

//Parallax effect HeaderView
@property(nonatomic) float headerParallaxScrollRatio;

//Refreshcontrol
-(void)endRefreshing;
@property(nonatomic) bool enableRefreshControl;
@property(nonatomic,copy) void (^refreshControlPulled)(void);

//Collapsing - override for example to fix iOS9 crashes...
-(void)collapseSection:(int)sectionIndex collapsed:(BOOL)collapsed;

//Utility methods
-(void)reloadHeightsQuickly;
-(BlazeRow *)rowForID:(int)rowID;
-(void)reloadTable:(BOOL)animated;
-(void)scrollToTop:(BOOL)animated;
-(void)reloadCellForID:(int)rowID;
-(void)removeRowWithID:(int)rowID;
-(void)reloadTableWithFadeTransition;
-(void)reloadCellForRow:(BlazeRow *)row;
-(void)removeSectionWithID:(int)sectionID;
-(void)addSection:(BlazeSection *)section;
-(NSIndexPath *)indexPathForRowID:(int)rowID;
-(BlazeSection *)sectionForID:(int)sectionID;
-(void)registerCustomCell:(NSString *)xibName;
-(NSIndexPath *)indexPathForRow:(BlazeRow *)row;
-(void)registerCustomHeader:(NSString *)xibName;
-(void)registerCustomCells:(NSArray *)cellNames;
-(void)registerCustomHeaders:(NSArray *)headerNames;
-(BlazeRow *)rowForIndexPath:(NSIndexPath *)indexPath;
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID;
-(void)reloadTableWithAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex;
-(void)addSection:(BlazeSection *)section afterSectionID:(int)afterSectionID;
-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowWithID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadCellForRow:(BlazeRow *)row withRowAnimation:(UITableViewRowAnimation)animation;
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID withRowAnimation:(UITableViewRowAnimation)animation;

@end























