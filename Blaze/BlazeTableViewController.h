//
//  BlazeTableViewController.h
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "BlazeTableRow.h"
#import "BlazeTableSection.h"
#import "NSObject+PropertyName.h"

@interface BlazeTableViewController : UITableViewController
{
    
}

//Xibname for all rows
@property(nonatomic,strong) NSString *rowsXibName;

//Empty set
@property(nonatomic) bool emptyScrollable;
@property(nonatomic) float emptyVerticalOffset;
@property(nonatomic,strong) UIImage *emptyImage;
@property(nonatomic,strong) NSString *emptyTitle;
@property(nonatomic,strong) UIColor *emptyBackgroundColor;
@property(nonatomic,strong) NSDictionary *emptyTitleAttributes;

//Methods to override
-(NSString *)defaultXIBForEnum:(BlazeTableRowType)rowType;

//TableArray
@property(nonatomic,strong) NSMutableArray *tableArray;

//DraggableZoom headerView
@property(nonatomic,strong) UIView *zoomTableHeaderView;

//Utility methods
-(void)reloadTable:(BOOL)animated;
-(void)scrollToTop:(BOOL)animated;
-(void)reloadCellForID:(int)rowID;
-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowWithID:(int)rowID;
-(void)removeRowWithID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(BlazeTableRow *)rowForID:(int)rowID;
-(void)removeSectionWithID:(int)sectionID;
-(void)addSection:(BlazeTableSection *)section;
-(NSIndexPath *)indexPathForRowID:(int)rowID;
-(void)registerCustomCell:(NSString *)xibName;
-(void)registerCustomHeader:(NSString *)xibName;
-(BlazeTableSection *)sectionForID:(int)sectionID;
-(void)registerCustomCells:(NSArray *)cellNames;
-(void)addRow:(BlazeTableRow *)row afterRowID:(int)afterRowID;
-(void)addRow:(BlazeTableRow *)row afterRowID:(int)afterRowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex;
-(void)addSection:(BlazeTableSection *)section afterSectionID:(int)afterSectionID;

@end























