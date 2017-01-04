//
//  BlazeTableViewController.m
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

//Defaults
#import "BlazeTableViewController.h"

//CollectionView
#import "BlazeTilesCollectionView.h"
#import "BlazeTileCollectionViewCell.h"

//Standard cells
#import "BlazeTableViewCell.h"

//TableViewHeaders
#import "BlazeTableHeaderFooterView.h"

//Definitions of basic XIB's
#define BlazeXIBDateCell              @"BlazeDateTableViewCell"
#define BlazeXIBTilesCell             @"BlazeTilesTableViewCell"
#define BlazeXIBSliderCell            @"BlazeSliderTableViewCell"
#define BlazeXIBSwitchCell            @"BlazeSwitchTableViewCell"
#define BlazeXIBCheckboxCell          @"BlazeCheckboxTableViewCell"
#define BlazeXIBTextViewCell          @"BlazeTextViewTableViewCell"
#define BlazeXIBTextFieldCell         @"BlazeTextFieldTableViewCell"
#define BlazeXIBPickerViewCell        @"BlazePickerViewTableViewCell"
#define BlazeXIBTwoChoicesCell        @"BlazeTwoChoicesTableViewCell"
#define BlazeXIBSegmentedControlCell  @"BlazeSegmentedControlTableViewCell"

@interface BlazeTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    
}

//The previous/next textfield does not work when using indexPaths, these are not correctly reset when not calling reloadData. Therefore this boolean is set to TRUE when adding/removing rows dynamically so that when a user requests the next/previous textfield, rowID's are used instead of indexpaths!
@property(nonatomic) bool dynamicRows;

//Indexes for sectionPicker
@property(nonatomic,strong) NSMutableArray *sectionIndexesArray;

//Contains names of current registered cells
@property(nonatomic,strong) NSMutableArray *registeredCells;
@property(nonatomic,strong) NSMutableArray *registeredHeaders;

@end

@implementation BlazeTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Arrays
    self.tableArray = [NSMutableArray new];
    self.sectionIndexesArray = [NSMutableArray new];
    
    //Register cells & Headers
    self.registeredCells = [NSMutableArray new];
    self.registeredHeaders = [NSMutableArray new];
    
    //Automatic rowHeight, estimates are necessary and do not really matter :)
    self.tableView.estimatedRowHeight = 60.0;
    self.tableView.estimatedSectionHeaderHeight = 60.0f;
    self.tableView.estimatedSectionFooterHeight = 60.0f;
    
    //No scrollbars
    self.tableView.showsVerticalScrollIndicator = FALSE;
    
    //Empty defaults
    self.emptyScrollable = TRUE;
    self.emptyVerticalOffset = -100.0f;
    self.emptyTableViewCellSeparatorStyle = -1;
    self.filledTableViewCellSeparatorStyle = -1;
    self.emptyBackgroundColor = [UIColor clearColor];
    
    //Empty datasource & delegate
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Load content on appear if active
    if(self.loadContentOnAppear) {
        [self loadTableContent];
    }
}

#pragma mark - Loading content

-(void)loadTableContent
{
    //Method to override
}

#pragma mark - Registering Cells/Headers

-(void)registerCustomCell:(NSString *)xibName
{
    //Check if registered already
    if([self.registeredCells containsObject:xibName]) {
        return;
    }
    
    //Register cell
    [self.tableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forCellReuseIdentifier:xibName];
    
    //Save
    [self.registeredCells addObject:xibName];
}

-(void)registerCustomHeader:(NSString *)xibName
{
    //Check if registered already
    if([self.registeredHeaders containsObject:xibName]) {
        return;
    }
    
    //Register header
    [self.tableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forHeaderFooterViewReuseIdentifier:xibName];
    
    //Save
    [self.registeredHeaders addObject:xibName];
}

-(void)registerCustomHeaders:(NSArray *)headerNames
{
    for(NSString *className in headerNames) {
        [self registerCustomHeader:className];
    }
}

-(void)registerCustomCells:(NSArray *)cellNames
{
    for(NSString *className in cellNames) {
        [self registerCustomCell:className];
    }
}

#pragma mark - RefreshControl

-(void)setEnableRefreshControl:(bool)enableRefreshControl
{
    _enableRefreshControl = enableRefreshControl;
    
    if(self.enableRefreshControl) {
        self.refreshControl = [UIRefreshControl new];
        [self.refreshControl addTarget:self action:@selector(startRefreshing) forControlEvents:UIControlEventValueChanged];
    }
    else {
        self.refreshControl = nil;
    }
}

-(void)startRefreshing
{
    //Check to be sure but shouldn't happen
    if(self.refreshControlPulled) {
        self.refreshControlPulled();
    }
}

-(void)endRefreshing
{
    [self.refreshControl endRefreshing];
}

#pragma mark ZoomTableHeaderView

-(void)setZoomTableHeaderView:(UIView *)zoomTableHeaderView
{
    _zoomTableHeaderView = zoomTableHeaderView;
    if(!zoomTableHeaderView) {
        return;
    }
    
    //Header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:self.zoomTableHeaderView.bounds];
    [headerContainer addSubview:self.zoomTableHeaderView];
    [headerContainer setClipsToBounds:NO];
    self.tableView.tableHeaderView = headerContainer;
}

#pragma mark Utility methods

-(void)reloadHeightsQuickly
{
    CGPoint currentOffset = self.tableView.contentOffset;
    [UIView setAnimationsEnabled:FALSE];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [self.tableView setContentOffset:currentOffset];
    [UIView setAnimationsEnabled:TRUE];
}

-(void)reloadTable:(BOOL)animated
{
    if(animated && ([self.tableView numberOfSections] == [self numberOfSectionsInTableView:self.tableView])) {
        NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadEmptyDataSet];
    }
    else {
        [self.tableView reloadData];
    }
}

-(void)reloadTableWithAnimation:(UITableViewRowAnimation)animation
{
    if([self.tableView numberOfSections] == [self numberOfSectionsInTableView:self.tableView]) {
        NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sections withRowAnimation:animation];
        [self.tableView reloadEmptyDataSet];
    }
    else {
        [self.tableView reloadData];
    }
}

-(void)reloadTableWithFadeTransition
{
    [UIView transitionWithView:self.tableView duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.tableView reloadData];
    } completion:^(BOOL finished) {
    }];
}

-(void)scrollToTop:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointZero animated:animated];
}

-(BlazeRow *)rowForID:(int)rowID
{
    for(int i = 0; i < self.tableArray.count; i++) {
        BlazeSection *section = self.tableArray[i];
        for(int j = 0; j < section.rows.count; j++) {
            BlazeRow *r = section.rows[j];
            if(r.ID == rowID) {
                return r;
            }
        }
    }
    return nil;
}

-(BlazeSection *)sectionForID:(int)sectionID
{
    for(int i = 0; i < self.tableArray.count; i++) {
        BlazeSection *section = self.tableArray[i];
        if(section.ID == sectionID) {
            return section;
        }
    }
    return nil;
}

-(BlazeRow *)rowForIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    if(sectionIndex >= self.tableArray.count) {
        return nil;
    }
    
    BlazeSection* s = self.tableArray[indexPath.section];
    if(rowIndex >= s.rows.count) {
        return nil;
    }
    
    return s.rows[rowIndex];
}

-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation
{
    //Let's get the indexPath of this cell
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

-(void)reloadCellForID:(int)rowID
{
    //Let's get the indexPath of this cell
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)reloadCellForRow:(BlazeRow *)row
{
    NSIndexPath *indexPath = [self indexPathForRow:row];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)reloadCellForRow:(BlazeRow *)row withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexPath = [self indexPathForRow:row];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

-(NSIndexPath *)indexPathForRow:(BlazeRow *)row
{
    NSUInteger rowIndex = NSNotFound;
    NSUInteger sectionIndex = NSNotFound;
    for(int i = 0; i < self.tableArray.count; i++) {
        BlazeSection *section = self.tableArray[i];
        for(int j = 0; j < section.rows.count; j++) {
            BlazeRow *r = section.rows[j];
            if(r == row) {
                rowIndex = j;
                sectionIndex = i;
                break;
            }
        }
        if(sectionIndex != NSNotFound) {
            break;
        }
    }
    
    if(sectionIndex == NSNotFound || rowIndex == NSNotFound) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

-(NSIndexPath *)indexPathForRowID:(int)rowID
{
    NSUInteger rowIndex = NSNotFound;
    NSUInteger sectionIndex = NSNotFound;
    for(int i = 0; i < self.tableArray.count; i++) {
        BlazeSection *section = self.tableArray[i];
        for(int j = 0; j < section.rows.count; j++) {
            BlazeRow *r = section.rows[j];
            if(r.ID == rowID) {
                rowIndex = j;
                sectionIndex = i;
                break;
            }
        }
        if(sectionIndex != NSNotFound) {
            break;
        }
    }
    
    if(sectionIndex == NSNotFound || rowIndex == NSNotFound) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

-(NSIndexPath *)indexPathForSectionID:(int)sectionID
{
    NSUInteger sectionIndex = NSNotFound;
    for(int i = 0; i < self.tableArray.count; i++) {
        BlazeSection *section = self.tableArray[i];
        if(section.ID == sectionID) {
            sectionIndex = i;
        }
    }
    
    if(sectionIndex == NSNotFound) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
}

#pragma mark - Next/Previous Field Responders

-(BlazeTableViewCell *)nextCellFromRow:(BlazeRow *)row
{
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:row.ID];
    if(!indexPath) {
        return nil;
    }
    
    return [self nextCellFromIndexPath:indexPath];
}

-(BlazeTableViewCell *)previousCellFromRow:(BlazeRow *)row
{
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:row.ID];
    if(!indexPath) {
        return nil;
    }
    
    return [self previousCellFromIndexPath:indexPath];
}

-(BlazeTableViewCell *)nextCellFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next indexPath in the same section
    NSIndexPath *nextRowIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    BlazeTableViewCell *nextRowCell = [self.tableView cellForRowAtIndexPath:nextRowIndexPath];
    if(nextRowCell) {
        return nextRowCell;
    }
    
    //Get next indexpath for the next section
    NSIndexPath *nextSectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section+1];
    BlazeTableViewCell *nextSectionCell = [self.tableView cellForRowAtIndexPath:nextSectionIndexPath];
    if(nextSectionCell) {
        return nextSectionCell;
    }
    
    //Nothing..
    return nil;
}

-(BlazeTableViewCell *)previousCellFromIndexPath:(NSIndexPath *)indexPath
{
    //Get previous indexPath in the same section
    NSIndexPath *previousRowIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
    BlazeTableViewCell *previousRowCell = [self.tableView cellForRowAtIndexPath:previousRowIndexPath];
    if(previousRowCell) {
        return previousRowCell;
    }
    
    //Get previous indexpath for the previous section
    int previousSectionIndex = (int)indexPath.section-1;
    if(previousSectionIndex < 0) {
        return nil;
    }
    
    BlazeSection *section = self.tableArray[previousSectionIndex];
    if(!section.rows.count) {
        return nil;
    }
    
    NSIndexPath *previousSectionIndexPath = [NSIndexPath indexPathForRow:section.rows.count-1 inSection:previousSectionIndex];
    BlazeTableViewCell *previousSectionCell = [self.tableView cellForRowAtIndexPath:previousSectionIndexPath];
    if(previousSectionCell) {
        return previousSectionCell;
    }
    
    //Nothing..
    return nil;
}

-(void)activateFirstResponderForCell:(BlazeTableViewCell *)cell
{
    if(cell && cell.canBecomeFirstResponder) {
        [cell becomeFirstResponder];
    }
    else {
        [self.view endEditing:TRUE];
    }
}

-(void)activateNextFieldFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next cell
    BlazeTableViewCell *cell = [self nextCellFromIndexPath:indexPath];
    [self activateFirstResponderForCell:cell];
}

-(void)activateNextFieldFromRowID:(int)rowID
{
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(indexPath) {
        [self activateNextFieldFromIndexPath:indexPath];
    }
    else {
        [self.view endEditing:TRUE];
    }
}

-(void)activatePreviousFieldFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next cell
    BlazeTableViewCell *cell = [self previousCellFromIndexPath:indexPath];
    [self activateFirstResponderForCell:cell];
}

-(void)activatePreviousFieldFromRowID:(int)rowID
{
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(indexPath) {
        [self activatePreviousFieldFromIndexPath:indexPath];
    }
    else {
        [self.view endEditing:TRUE];
    }
}

#pragma mark - Collapsing

-(void)collapseSection:(int)sectionIndex collapsed:(BOOL)collapsed
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Possibly delete rows
    BlazeSection *section = self.tableArray[sectionIndex];
    NSMutableArray *indexPaths = [NSMutableArray new];
    
    //Remove rows/indexpaths
    for(int i = 0; i < section.rows.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
    }
    
    //Check if we need to delete any
    if(!indexPaths.count) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Add/remove rows
    if(collapsed) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:section.collapseAnimation];
    }
    else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:section.collapseAnimation];
    }
    
    
    //End updates
    [self.tableView endUpdates];
}

#pragma mark Adding/Removing Rows/Sections

-(void)addSection:(BlazeSection *)section
{
    [self.tableArray addObject:section];
}

-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Possibly delete rows
    BlazeSection *section = self.tableArray[sectionIndex];
    NSMutableArray *indexPathsToDelete = [NSMutableArray new];
    
    //Remove rows/indexpaths
    for(int i = (int)section.rows.count-1; i > rowIndex-1; i--) {
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
        [section.rows removeObject:section.rows[i]];
    }
    
    //Check if we need to delete any
    if(!indexPathsToDelete.count) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove rows
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)removeRowWithID:(int)rowID
{
    [self removeRowWithID:rowID withRowAnimation:UITableViewRowAnimationFade];
}

-(void)removeRowWithID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    
    //Sanity check
    if(!indexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove row from array
    BlazeSection *section = self.tableArray[indexPath.section];
    [section.rows removeObjectAtIndex:indexPath.row];
    
    //Remove row
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)removeSectionWithID:(int)sectionID
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Get section
    BlazeSection *section = [self sectionForID:sectionID];
    
    //Sanity check
    if(!section) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForSectionID:sectionID];
    
    //Sanity check
    if(!indexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove row from array
    [self.tableArray removeObject:section];
    
    //Remove section in tableview
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID
{
    [self addRow:row afterRowID:afterRowID withRowAnimation:UITableViewRowAnimationFade];
}

-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID withRowAnimation:(UITableViewRowAnimation)animation
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Row exists
    NSIndexPath *existingIndexPath = [self indexPathForRowID:row.ID];
    if(existingIndexPath) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *currentIndexPath = [self indexPathForRowID:afterRowID];
    
    //Sanity check
    if(!currentIndexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //New indexPath
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row+1 inSection:currentIndexPath.section];
    
    //Insert row in section
    BlazeSection *section = self.tableArray[newIndexPath.section];
    [section.rows insertObject:row atIndex:newIndexPath.row];
    
    //Add cell
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:animation];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)addSection:(BlazeSection *)section afterSectionID:(int)afterSectionID
{
    //Dynamic rows
    self.dynamicRows = TRUE;
    
    //Section exists already?
    if([self sectionForID:section.ID]) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *currentIndexPath = [self indexPathForSectionID:afterSectionID];
    
    //Sanity check
    if(!currentIndexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //New indexPath
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:currentIndexPath.section+1];
    
    //Insert section
    [self.tableArray insertObject:section atIndex:newIndexPath.section];
    
    //Add cell
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BlazeSection *s = self.tableArray[section];
    if(s.collapsed) {
        return 0;
    }
    return s.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlazeSection *s = self.tableArray[indexPath.section];
    BlazeRow *row = s.rows[indexPath.row];
    
    if(row.rowHeight) {
        return row.rowHeight;
    }
    else if(row.rowHeightRatio) {
        return row.rowHeightRatio * tableView.frame.size.height;
    }
    else if(row.rowHeightDynamic) {
        float nrOfDynamicHeights = 0;
        float height = tableView.frame.size.height;
        for(BlazeSection *section in self.tableArray) {
            for(BlazeRow *row in section.rows) {
                if(row.rowHeight) {
                    height -= row.rowHeight;
                }
                else if(row.rowHeightRatio) {
                    height -= row.rowHeightRatio * tableView.frame.size.height;
                }
                else if(row.rowHeightDynamic) {
                    nrOfDynamicHeights++;
                }
            }
        }
        if(nrOfDynamicHeights>1) {
            return height/nrOfDynamicHeights;
        }
        return height;
    }
    else if(self.rowHeight) {
        return self.rowHeight;
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BlazeSection *s = self.tableArray[section];
    if(s.headerHeight) {
        return s.headerHeight;
    }
    else if(self.sectionHeaderHeight) {
        return self.sectionHeaderHeight;
    }
    else if(s.headerTitle.length) {
        return UITableViewAutomaticDimension;
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    BlazeSection *s = self.tableArray[section];
    if(s.footerHeight) {
        return s.footerHeight;
    }
    else if(self.sectionFooterHeight) {
        return self.sectionFooterHeight;
    }
    else if(s.footerTitle.length) {
        return UITableViewAutomaticDimension;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BlazeSection *s = self.tableArray[section];
    if(!(s.headerTitle.length) && !s.headerHeight) {
        return nil;
    }
    
    BlazeTableHeaderFooterView *headerView;
    if(s.headerXibName.length) {
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:s.headerXibName];
    }
    else if(self.headerXibName.length) {
        headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerXibName];
    }
    
    //Collapsing
    if(s.canCollapse) {
        __weak __typeof(self)weakSelf = self;
        __weak __typeof(BlazeSection *)weakSection = s;
        [s setCollapseTapped:^{
            [weakSelf collapseSection:(int)section collapsed:weakSection.collapsed];
        }];
    }
    
    //Update
    headerView.sectionType = SectionHeader;
    
    //Set it
    headerView.section = s;
    
    //Configure
    if(s.configureHeaderView) {
        s.configureHeaderView(headerView);
    }
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BlazeSection *s = self.tableArray[section];
    if(!(s.footerTitle.length) && !s.footerHeight) {
        return nil;
    }
    
    BlazeTableHeaderFooterView *footerView;
    if(s.footerXibName.length) {
        footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:s.footerXibName];
    }
    else if(self.footerXibName.length) {
        footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerXibName];
    }
    footerView.titleLabel.text = s.footerTitle;
    
    //Update
    footerView.sectionType = SectionFooter;
    
    //Set it
    footerView.section = s;
    
    //Configure
    if(s.configureFooterView) {
        s.configureFooterView(footerView);
    }
    
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlazeSection *section = self.tableArray[indexPath.section];
    BlazeRow *row = section.rows[indexPath.row];
    
    NSString *cellName;
    if(row.xibName.length) {
        cellName = row.xibName;
    }
    else if(section.rowsXibName.length) {
        cellName = section.rowsXibName;
    }
    else if(self.rowsXibName.length) {
        cellName = self.rowsXibName;
    }
    
    BlazeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    //You could choose to return the cell here and configure in willdisplay but I found out that the UITableViewAutomaticDimension does not work anymore when you do that... So I will configure the cell here...
    
    //Update row object
    cell.row = row;
    
    //Separator inset
    if(self.noSeparatorInset) {
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = FALSE;
    }
    
    //Selection background color
    if(row.selectionBackgroundColor) {
        UIView *view = [UIView new];
        view.backgroundColor = row.selectionBackgroundColor;
        cell.selectedBackgroundView = view;
    }
    
    //Completion blocks
    [cell setHeightUpdated:^{
        CGPoint currentOffset = tableView.contentOffset;
        [UIView setAnimationsEnabled:FALSE];
        [tableView beginUpdates];
        [tableView endUpdates];
        [tableView setContentOffset:currentOffset];
        [UIView setAnimationsEnabled:TRUE];
    }];
    [cell setNextField:^{
        if(self.dynamicRows) {
            [self activateNextFieldFromRowID:row.ID];
        }
        else {
            [self activateNextFieldFromIndexPath:indexPath];
        }
    }];
    [cell setPreviousField:^{
        if(self.dynamicRows) {
            [self activatePreviousFieldFromRowID:row.ID];
        }
        else {
            [self activatePreviousFieldFromIndexPath:indexPath];
        }
    }];
    
    //Custom cell to configure
    if(row.configureCell) {
        row.configureCell(cell);
    }
    
    //Return
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(!self.useSectionIndexPicker) {
        return nil;
    }
    return self.sectionIndexesArray;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(!self.useSectionIndexPicker) {
        return NSNotFound;
    }
    return [self.sectionIndexesArray indexOfObject:title];
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlazeSection *s = self.tableArray[indexPath.section];
    BlazeRow *row = s.rows[indexPath.row];
    if(row.cellTapped) {
        row.cellTapped();
    }
    else if(row.segueIdentifier.length) {
        [self performSegueWithIdentifier:row.segueIdentifier sender:self];
    }
    else if(row.storyboardID.length && row.storyboardName.length) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:row.storyboardName bundle:nil] instantiateViewControllerWithIdentifier:row.storyboardID];
        [self.navigationController pushViewController:vc animated:TRUE];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView != self.tableView) {
        return;
    }
    
    [self.view endEditing:TRUE];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView != self.tableView) {
        return;
    }
    
    if(!self.zoomTableHeaderView) {
        return;
    }
    
    float offset = scrollView.contentOffset.y;
    if(offset > 0) {
        if(self.headerParallaxScrollRatio<=0) {
            return;
        }
        CGRect headerFrame = self.zoomTableHeaderView.frame;
        headerFrame.origin.y = -offset+(offset * (1+self.headerParallaxScrollRatio));
        self.zoomTableHeaderView.frame = headerFrame;
        return;
    }
    CGRect headerFrame = self.zoomTableHeaderView.frame;
    headerFrame.origin.y = offset;
    headerFrame.size.width = CGRectGetWidth(self.tableView.tableHeaderView.bounds);
    headerFrame.size.height = CGRectGetHeight(self.tableView.tableHeaderView.bounds) + fabs(offset);
    self.zoomTableHeaderView.frame = headerFrame;
    [self.zoomTableHeaderView layoutIfNeeded];
}

#pragma mark - DNZEmptyDataSet delegates

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if(self.emptyAttributedTitle) {
        return self.emptyAttributedTitle;
    }
    if(!(self.emptyTitle.length)) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:self.emptyTitle attributes:self.emptyTitleAttributes];
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyImage;
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyBackgroundColor;
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyVerticalOffset;
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return self.emptyScrollable;
}

-(void)emptyDataSetWillReload:(UIScrollView *)scrollView
{
    if(self.useSectionIndexPicker) {
        [self.sectionIndexesArray removeAllObjects];
    }
    
    for(BlazeSection *s in self.tableArray) {
        //Section header/footer
        if(s.headerXibName.length) {
            [self registerCustomHeader:s.headerXibName];
            if(self.useSectionIndexPicker && s.headerTitle.length) {
                [self.sectionIndexesArray addObject:[[s.headerTitle substringToIndex:1] uppercaseString]];
            }
        }
        if(s.footerXibName.length) {
            [self registerCustomHeader:s.footerXibName];
        }
        
        //Section rows
        if(s.rowsXibName.length) {
            [self registerCustomCell:s.rowsXibName];
        }
        
        //Rows
        for(BlazeRow *r in s.rows) {
            if(r.xibName.length) {
                [self registerCustomCell:r.xibName];
            }
        }
    }
    
    //Self headers/cells
    if(self.headerXibName.length) {
        [self registerCustomHeader:self.headerXibName];
    }
    if(self.footerXibName.length) {
        [self registerCustomHeader:self.footerXibName];
    }
    
    //Self rows
    if(self.rowsXibName.length) {
        [self registerCustomCell:self.rowsXibName];
    }
    
    //Separator style
    if((int)self.emptyTableViewCellSeparatorStyle != -1 && (int)self.filledTableViewCellSeparatorStyle != -1) {
        if(self.tableArray.count) {
            self.tableView.separatorStyle = self.filledTableViewCellSeparatorStyle;
        }
        else {
            self.tableView.separatorStyle = self.emptyTableViewCellSeparatorStyle;
        }
    }
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyCustomView;
}

#pragma mark Dealloc

-(void)dealloc
{
    self.tableView.emptyDataSetDelegate = nil;
    self.tableView.emptyDataSetSource = nil;
    self.tableView.delegate = nil;
}

@end


















