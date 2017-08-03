//
//  BlazeNSFetchedTableViewController.m
//  BlazeExample
//
//  Created by Bob de Graaf on 14-12-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeNSFetchedTableViewController.h"

@interface BlazeNSFetchedTableViewController () <NSFetchedResultsControllerDelegate>
{
    
}

@property(nonatomic,strong) NSMutableDictionary *updatedRows;
@property(nonatomic,strong) NSMutableDictionary *insertedRows;
@property(nonatomic,strong) NSMutableArray *deletedRowIndexPaths;
@property(nonatomic,strong) NSMutableDictionary *insertedSections;
@property(nonatomic,strong) NSMutableArray *deletedSectionIndexes;

@property(nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation BlazeNSFetchedTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Disabling
    if(self.disableFetchedResults) {
        return;
    }
    
    //Default animation
    self.deleteAnimation = UITableViewRowAnimationLeft;
    self.insertAnimation = UITableViewRowAnimationRight;
    self.updateAnimation = UITableViewRowAnimationAutomatic;
    
    //Arrays/Dictionaries
    self.updatedRows = [NSMutableDictionary new];
    self.insertedRows = [NSMutableDictionary new];
    self.deletedRowIndexPaths = [NSMutableArray new];
    self.insertedSections = [NSMutableDictionary new];
    self.deletedSectionIndexes = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Disabling
    if(self.disableFetchedResults) {
        return;
    }
 
    //Fetchedresultscontroller
    if(!self.fetchedResultsController) {
        [self initializeFetchedResultsController];
    }
}

#pragma mark - FetchedResultsController

-(void)initializeFetchedResultsController
{    
    //Create fetch request
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.entityName];
    request.predicate = self.predicate;
    request.sortDescriptors = self.sortDescriptors;
    
    //Create fetchedresultscontroller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:self.sectionNameKeyPath cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    //Start
    [self startFetching];
}

-(void)updatePredicate:(NSPredicate *)predicate
{
    [NSFetchedResultsController deleteCacheWithName:nil];
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    [self startFetching];
}

-(void)updatePredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
    [NSFetchedResultsController deleteCacheWithName:nil];
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors;
    [self startFetching];
}

-(void)startFetching
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Start initial fetch
    NSError *error = nil;
    if(![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        [self.tableView reloadData];
        return;
    }
    
    //PrefixSections
    if(self.prefixSections) {
        [self.tableArray addObjectsFromArray:self.prefixSections];
    }
    
    //Create initial data
    for(int i = 0; i < self.fetchedResultsController.sections.count; i++) {
        id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[i];
        BlazeSection *section = [self sectionForSectionInfo:sectionInfo];
        [self.tableArray addObject:section];
        for(int j = 0; j < [sectionInfo numberOfObjects]; j++) {
            BlazeRow *row = [self rowForObject:[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]]];
            [section addRow:row];
        }
    }
    
    //Reload
    [self.tableView reloadData];
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    sectionIndex = sectionIndex + self.prefixSections.count;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            //NSLog(@"Insert section: %d", (int)sectionIndex);
            self.insertedSections[@(sectionIndex)] = sectionInfo;
            break;
        case NSFetchedResultsChangeDelete:
            //NSLog(@"Delete section: %d", (int)sectionIndex);
            [self.deletedSectionIndexes addObject:@(sectionIndex)];
            break;
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    int prefixSectionsCount = (int)self.prefixSections.count;
    indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section+prefixSectionsCount];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:newIndexPath.section+prefixSectionsCount];
    
    if(type == NSFetchedResultsChangeInsert) {
        //NSLog(@"Insert row: %d-%d", (int)newIndexPath.section, (int)newIndexPath.row);
        self.insertedRows[newIndexPath] = anObject;
    } else if(type == NSFetchedResultsChangeDelete) {
        //NSLog(@"Delete row: %d-%d", (int)indexPath.section, (int)indexPath.row);
        [self.deletedRowIndexPaths addObject:indexPath];
    } else if(type == NSFetchedResultsChangeMove) {
        //NSLog(@"Move row: %d-%d to %d-%d", (int)indexPath.section, (int)indexPath.row, (int)newIndexPath.section, (int)newIndexPath.row);
        self.insertedRows[newIndexPath] = anObject;
        [self.deletedRowIndexPaths addObject:indexPath];
    } else if(type == NSFetchedResultsChangeUpdate) {
        //NSLog(@"Updating row: %d-%d", (int)indexPath.section, (int)indexPath.row);
        self.updatedRows[indexPath] = anObject;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //Begin updates
    [self.tableView beginUpdates];
    
    //Deleted rows
    NSMutableArray *rowObjects = [NSMutableArray new];
    for(NSIndexPath *indexPath in self.deletedRowIndexPaths) {
        BlazeSection *section = self.tableArray[indexPath.section];
        [rowObjects addObject:section.rows[indexPath.row]];
    }
    
    //Loop through sections to delete all rows at once using the rowsarray to solve multiple row deletion issues when deleting one-by-one
    for(BlazeSection *section in self.tableArray) {
        [section.rows removeObjectsInArray:rowObjects];
    }
    [self.tableView deleteRowsAtIndexPaths:self.deletedRowIndexPaths withRowAnimation:self.deleteAnimation];
    
    //Deleted sections
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    for(NSNumber *sectionIndex in self.deletedSectionIndexes) {
        [indexSet addIndex:[sectionIndex integerValue]];
        [self.tableArray removeObjectAtIndex:[sectionIndex integerValue]];
    }
    [self.tableView deleteSections:indexSet withRowAnimation:self.deleteAnimation];
    
    //Inserted sections
    indexSet = [NSMutableIndexSet new];
    for(NSNumber *sectionIndex in self.insertedSections.allKeys) {
        [indexSet addIndex:[sectionIndex integerValue]];
        BlazeSection *section = [self sectionForSectionInfo:self.insertedSections[sectionIndex]];
        [self.tableArray insertObject:section atIndex:[sectionIndex integerValue]];
    }
    [self.tableView insertSections:indexSet withRowAnimation:self.insertAnimation];
    
    //Add rows
    NSMutableArray *indexPathsArray = [NSMutableArray new];
    //Sort keys first to row because otherwise section might insert at Index while index below does not exist yet
    NSArray *allKeys = [self.insertedRows.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"row" ascending:TRUE]]];
    for(NSIndexPath *indexPath in allKeys) {
        BlazeSection *section = self.tableArray[indexPath.section];
        BlazeRow *row = [self rowForObject:self.insertedRows[indexPath]];
        [section.rows insertObject:row atIndex:indexPath.row];
        [indexPathsArray addObject:indexPath];
    }
    [self.tableView insertRowsAtIndexPaths:indexPathsArray withRowAnimation:self.insertAnimation];
    
    //Update rows
    indexPathsArray = [NSMutableArray new];
    for(NSIndexPath *indexPath in self.updatedRows.allKeys) {
        BlazeSection *section = self.tableArray[indexPath.section];
        BlazeRow *row = [self rowForObject:self.updatedRows[indexPath]];
        [section.rows replaceObjectAtIndex:indexPath.row withObject:row];
        [indexPathsArray addObject:indexPath];
    }
    [self.tableView reloadRowsAtIndexPaths:indexPathsArray withRowAnimation:self.updateAnimation];
    
    //End updates
    [self.tableView endUpdates];
    
    //Clear
    [self.updatedRows removeAllObjects];
    [self.insertedRows removeAllObjects];
    [self.insertedSections removeAllObjects];
    [self.deletedRowIndexPaths removeAllObjects];
    [self.deletedSectionIndexes removeAllObjects];
}

#pragma mark - FetchedResultsController section/rows

-(BlazeSection *)sectionForSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo
{
    //Can be overridden if necessary
    BlazeSection *section = [BlazeSection new];
    section.headerXibName = self.headerXibName;
    section.headerTitle = [sectionInfo name];
    return section;
}

-(BlazeRow *)rowForObject:(NSManagedObject *)object
{
    //To override
    return nil;
}

-(void)contentUpdated
{
    //To override
}

#pragma mark - Deleting

-(void)deleteObjectForIndexpath:(NSIndexPath *)indexPath
{
    BlazeSection *s = self.tableArray[indexPath.section];
    BlazeRow *row = s.rows[indexPath.row];
    
    //Delete object - the rest will automatically follow
    [self.managedObjectContext deleteObject:row.object];
    
    //Save
    [self.managedObjectContext save:nil];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlazeSection *s = self.tableArray[indexPath.section];
    BlazeRow *row = s.rows[indexPath.row];
    return self.enableDeleting && row.object && !row.disableEditing;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteObjectForIndexpath:indexPath];
    }
}

#pragma mark - Dealloc

-(void)dealloc
{
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
}

@end





















