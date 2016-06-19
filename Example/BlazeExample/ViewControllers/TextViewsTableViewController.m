//
//  TextViewsTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 14-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "TextViewsTableViewController.h"

@interface TextViewsTableViewController ()
{
    
}

@property(nonatomic,strong) NSString *textViewValue1;
@property(nonatomic,strong) NSString *textViewValue2;

@end

@implementation TextViewsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load table
    [self loadTable];
}

-(void)loadTable
{
    //Row & Section
    BlazeTableRow *row;
    BlazeTableSection *section;
    
    //Textview
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"In Blaze textviews automagically increase their own cellheight dynamically while typing."];
    [self addSection:section];
    
    //Textview 1
    row = [[BlazeTableRow alloc] initWithXibName:kTextViewTableViewCell rowType:BlazeRowTextView title:@"Textview below"];
    row.placeholder = @"Textview 1";
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(textViewValue1)]];
    [section addRow:row];
    
    //Textview 2
    section = [[BlazeTableSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Oh yeah, these textviews also have placeholders! (They normally don't...)"];
    [self addSection:section];
    
    //Textview 2
    row = [[BlazeTableRow alloc] initWithXibName:kTextViewTableViewCell rowType:BlazeRowTextView title:@"Textview below"];
    row.placeholder = @"Placeholder awesomeness";
    [row setAffectedObject:self affectedPropertyName:[self stringForPropertyName:@selector(textViewValue2)]];
    [section addRow:row];
}

@end
