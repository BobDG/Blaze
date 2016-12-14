//
//  BDGCoreData.h
//  Template
//
//  Created by Bob de Graaf on 01-06-15.
//  Copyright (c) 2015 Synappz BV. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

#define kCoreData [BDGCoreData sharedBDGCoreData]

@interface BDGCoreData : NSObject
{
    
}

-(void)saveContext;
-(NSArray *)objectsForEntity:(NSString *)entityName;
-(void)deleteObjectsForEntity:(NSString *)entityName;
-(id)objectWithID:(NSString *)id forEntity:(NSString *)entity;
-(NSManagedObject *)objectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;
-(NSArray *)objectsWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;
-(NSManagedObject *)firstObjectForEntity:(NSString *)entityName usingSortKey:(NSString *)key ascending:(BOOL)asc;

//Predicates
-(NSPredicate *)todayDatesPredicate;
-(NSPredicate *)datesPredicateForDate:(NSDate *)date;
-(NSPredicate *)datesPredicateForDates:(NSDate *)startDate endDate:(NSDate *)endDate;
-(NSPredicate *)datesPredicateForDates:(NSDate *)startDate endDate:(NSDate *)endDate startKey:(NSString *)startKey endKey:(NSString*)endKey;

//Singleton
+(BDGCoreData *)sharedBDGCoreData;

//References
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong) NSManagedObjectContext *privateManagedObjectContext;

@end
