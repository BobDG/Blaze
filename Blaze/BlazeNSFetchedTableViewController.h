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

//Prefix sections
@property(nonatomic,strong) NSArray<BlazeSection *> *prefixSections;

//FetchedResults properties
@property(nonatomic) bool disableFetchedResults;
@property(nonatomic,strong) NSString *entityName;
@property(nonatomic,strong) NSPredicate *predicate;
@property(nonatomic,strong) NSArray *sortDescriptors;
@property(nonatomic,strong) NSString *sectionNameKeyPath;
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

//Animations (Delete defaults to left, Insert defaults to right, update automatic)
@property(nonatomic) UITableViewRowAnimation deleteAnimation;
@property(nonatomic) UITableViewRowAnimation insertAnimation;
@property(nonatomic) UITableViewRowAnimation updateAnimation;

//Deleting
@property(nonatomic) bool enableDeleting;

//Updating predicate dynamically
-(void)updatePredicate:(NSPredicate *)predicate;
-(void)updatePredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

//Methods to override
-(void)contentUpdated;
-(BlazeRow *)rowForObject:(NSManagedObject *)object;
-(BlazeSection *)sectionForSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo;

@end
