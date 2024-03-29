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
    
    //Section header/footer
    self.tableView.estimatedSectionHeaderHeight = 40;
    self.tableView.estimatedSectionFooterHeight = 40;
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Row & Section
    BlazeRow *row;
    BlazeSection *section;
    
    //Textview
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"In Blaze textviews automagically increase their own cellheight dynamically while typing."];
    [self addSection:section];
    
    //Textview 1
    row = [[BlazeRow alloc] initWithXibName:kTextViewTableViewCell title:@"Textview below"];
    row.placeholder = @"Textview 1";
    [row setAffectedWeakObject:self affectedPropertyName:[self stringForPropertyName:@selector(textViewValue1)]];
    [row setValueChanged:^{
        NSLog(@"Textview 1 changed: %@", self.textViewValue1);
    }];
    [row setDoneChanging:^{
        NSLog(@"Done changing!");
    }];
    [section addRow:row];
    
    //Textview 2
    section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Oh yeah, these textviews also have placeholders! (They normally don't...)"];
    [self addSection:section];
    
    //Textview 2
    row = [[BlazeRow alloc] initWithXibName:kTextViewTableViewCell title:@"Textview below"];
    row.placeholder = @"Placeholder awesomeness";
    [row setAffectedWeakObject:self affectedPropertyName:[self stringForPropertyName:@selector(textViewValue2)]];
    [row setValueChanged:^{
        NSLog(@"Textview 2 changed: %@", self.textViewValue2);
    }];
    [section addRow:row];
    
    //Reload
    [self.tableView reloadData];
}

@end
