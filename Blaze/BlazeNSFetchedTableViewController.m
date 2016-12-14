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

@property(nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation BlazeNSFetchedTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
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
    
    //Start initial fetch
    NSError *error = nil;
    if(![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        return;
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

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            BlazeSection *section = [self sectionForSectionInfo:sectionInfo];
            [self.tableArray insertObject:section atIndex:sectionIndex];
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationRight];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableArray removeObjectAtIndex:sectionIndex];
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            BlazeSection *section = self.tableArray[newIndexPath.section];
            BlazeRow *row = [self rowForObject:anObject];
            [section.rows insertObject:row atIndex:newIndexPath.row];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            BlazeSection *section = self.tableArray[indexPath.section];
            [section.rows removeObjectAtIndex:indexPath.row];
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            BlazeSection *section = self.tableArray[indexPath.section];
            BlazeRow *newRow = [self rowForObject:anObject];
            [section.rows replaceObjectAtIndex:indexPath.row withObject:newRow];
            
            //Reload
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeMove: {
            //Get sections
            BlazeSection *section1 = self.tableArray[indexPath.section];
            BlazeSection *section2 = self.tableArray[newIndexPath.section];
            
            //Get new row
            BlazeRow *row = [self rowForObject:anObject];
            
            //Remove previous
            [section1.rows removeObjectAtIndex:indexPath.row];
            
            //Insert row
            [section2.rows insertObject:row atIndex:newIndexPath.row];
            
            //Move within tableview
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
    //Notify
    [self contentUpdated];
}

#pragma mark - FetchedResultsController section/rows

-(BlazeSection *)sectionForSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo
{
    //Can be overridden if necessary
    BlazeSection *section = [BlazeSection new];
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





















