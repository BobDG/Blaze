//
//  FetchedResultsTableViewController.m
//  BlazeExample
//
//  Created by Bob de Graaf on 14-12-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "TestEntity.h"
#import "BaseTableViewController.h"
#import "FetchedResultsTableViewController.h"

@interface FetchedResultsTableViewController ()

@end

@implementation FetchedResultsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Testing with these variables to get rid of stupid Apple bug - jumpy scrolling when at the bottom of the table and changes happen.
    self.tableView.estimatedRowHeight = 40.0f;
    self.tableView.estimatedSectionHeaderHeight = 30.0f;
    self.tableView.rowHeight = 40.0f;
    self.tableView.sectionHeaderHeight = 30.0f;
    self.tableView.sectionFooterHeight = 10.0f;
    
    //Enable deleting
    self.enableDeleting = TRUE;
    
    //Fetched results properties
    self.entityName = [TestEntity entityName];    
    self.managedObjectContext = kCoreData.managedObjectContext;
    self.sectionNameKeyPath = @"index";
    self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:TRUE], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE]];
    
    //Textfield section
    BlazeSection *section = [[BlazeSection alloc] initWithHeaderXibName:kTableHeaderView headerTitle:@"Prefix sections above fetched content :)"];
    [self addSection:section];
    
    //Textfield
    BlazeRow *row = [[BlazeRow alloc] initWithXibName:kFloatTextFieldTableViewCell];
    row.floatingLabelEnabled = TRUE;
    row.floatingTitleActiveColor = [UIColor redColor];
    row.floatingTitleFont = [UIFont italicSystemFontOfSize:12.0f];
    row.floatingTitle = @"Floating placeholder";
    row.placeholder = @"Placeholder";
    [section addRow:row];
    
    //Prefix sections
    self.prefixSections = @[section];
}

#pragma mark - Methods to override

-(BlazeRow *)rowForObject:(NSManagedObject *)object
{
    //EntityTest
    TestEntity *testEntity = (TestEntity *)object;
    
    //Return row
    BlazeRow *row = [BlazeRow rowWithXibName:kTextTableViewCell title:testEntity.name];
    row.object = object;
    __weak __typeof(self)weakSelf = self;
    [row setCellTapped:^{
        [weakSelf changeEntityName:testEntity];
    }];
    row.enableDeleting = TRUE;
    [row setCellDeleted:^{
        [kCoreData.managedObjectContext deleteObject:object];
        [kCoreData saveContext];
    }];
    return row;
}

-(BlazeSection *)sectionForSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo
{
    BlazeSection *section = [BlazeSection new];
    section.headerXibName = kTableHeaderView;
    section.headerTitle = [sectionInfo name];
    return section;
}

-(void)contentUpdated
{
    DLog(@"Content is updated!");
}

#pragma mark - Update names to check correct moving of rows

-(void)changeEntityName:(TestEntity *)testEntity
{
    DLog(@"Updating entity with previous name: %@, section: %d", testEntity.name, testEntity.indexValue);
    testEntity.name = [NSString stringWithFormat:@"Random entity name %d", arc4random()%10];
    testEntity.indexValue = arc4random()%7;
    DLog(@"Updating entity to new name: %@, section: %d", testEntity.name, testEntity.indexValue);
    [kCoreData saveContext];
}

#pragma mark - Actions

-(IBAction)addEntity:(id)sender
{
    TestEntity *testEntity = [TestEntity insertInManagedObjectContext:self.managedObjectContext];
    testEntity.name = [NSString stringWithFormat:@"Random entity name %d", arc4random()%10];
    testEntity.indexValue = arc4random()%7;
    DLog(@"Created entity with name: %@, section: %d", testEntity.name, testEntity.indexValue);
    [kCoreData saveContext];
}

@end
