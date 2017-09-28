//
//  Mapping.h
//  IkHerstel
//
//  Created by Bob de Graaf on 15-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Mapping)
{
    
}

-(NSDictionary *)dictionaryFromProperties;
-(NSDictionary *)dictionaryFromProperties:(NSDateFormatter *)dateFormatter;


-(void)copyPropertiesToObject:(NSManagedObject *)object;
-(void)copyPropertiesToObject:(NSManagedObject *)object context:(NSManagedObjectContext *)context;
-(void)copyPropertiesToObject:(NSManagedObject *)object context:(NSManagedObjectContext *)context excludeRelationships:(NSArray *)excludeRelationships;

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues context:(NSManagedObjectContext *)context;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays mappingDictionary:(NSDictionary *)mappingDictionary;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays mappingDictionary:(NSDictionary *)mappingDictionary excludeRelationships:(NSArray *)excludeRelationships;

@end
