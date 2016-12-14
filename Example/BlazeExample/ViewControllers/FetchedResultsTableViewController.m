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
    
    //Estimated rowheight
    self.tableView.estimatedRowHeight = 40.0f;
    self.tableView.estimatedSectionHeaderHeight = 30.0f;
    self.tableView.rowHeight = 40.0f;
    self.tableView.sectionHeaderHeight = 30.0f;
    self.tableView.sectionFooterHeight = 10.0f;
    
    self.enableDeleting = TRUE;
    self.entityName = [TestEntity entityName];    
    self.managedObjectContext = kCoreData.managedObjectContext;
    self.sectionNameKeyPath = @"index";
    self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:TRUE], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE]];
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
    //testEntity.indexValue = arc4random()%3;
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
