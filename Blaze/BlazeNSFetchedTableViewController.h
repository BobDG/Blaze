//
//  BlazeNSFetchedTableViewController.h
//  BlazeExample
//
//  Created by Bob de Graaf on 14-12-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "BlazeTableViewController.h"

@interface BlazeNSFetchedTableViewController : BlazeTableViewController
{
    
}

//FetchedResults properties
@property(nonatomic) bool disableFetchedResults;
@property(nonatomic,strong) NSString *entityName;
@property(nonatomic,strong) NSPredicate *predicate;
@property(nonatomic,strong) NSArray *sortDescriptors;
@property(nonatomic,strong) NSString *sectionNameKeyPath;
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

//Deleting
@property(nonatomic) bool enableDeleting;

//Updating predicate dynamically
-(void)updatePredicate:(NSPredicate *)predicate;

//Methods to override
-(void)contentUpdated;
-(BlazeRow *)rowForObject:(NSManagedObject *)object;
-(BlazeSection *)sectionForSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo;

@end
