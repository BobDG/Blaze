//
//  Mapping.m
//  IkHerstel
//
//  Created by Bob de Graaf on 15-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "NSManagedObject+Mapping.h"

@implementation NSManagedObject (Mapping)

-(void)copyPropertiesToObject:(NSManagedObject *)object
{
    NSDictionary *fromAttributes = [[self entity] attributesByName];
    NSArray *toAttributes = [[object entity] attributesByName].allKeys;
    for(NSString *attributeName in fromAttributes) {
        if(![toAttributes containsObject:attributeName]) {
            continue;
        }
        
        //Set it
        [object setValue:[self valueForKey:attributeName] forKey:attributeName];
    }
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for(NSString *attribute in attributes) {
        id value = [keyedValues objectForKey:attribute];
        if(value == nil) {
            continue;
        }
        if(value == [NSNull null]) {
            continue;
        }
        
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
            value = [dateFormatter dateFromString:value];
        }
        [self setValue:value forKey:attribute];
    }
    
    NSDictionary *relationships = [[self entity] relationshipsByName];
    for(NSString *relationship in relationships) {
        id value = [keyedValues objectForKey:relationship];
        if(value == nil) {
            continue;
        }
        if(value == [NSNull null]) {
            continue;
        }
        if(![value isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        //If the relationship does not exist, create the object and add the relation
        NSManagedObject *relationshipObject = (NSManagedObject *)[self valueForKey:relationship];
        if(!relationshipObject) {
            NSString *capitalizedFirstLetter = [[relationship substringToIndex:1] uppercaseString];
            NSString *otherLetters = [relationship substringFromIndex:1];
            NSString *relationShipClassName = [NSString stringWithFormat:@"%@%@", capitalizedFirstLetter, otherLetters];            
            relationshipObject = [NSEntityDescription insertNewObjectForEntityForName:relationShipClassName inManagedObjectContext:context];
            [self setValue:relationshipObject forKey:relationship];
        }
        
        //Update values
        [relationshipObject safeSetValuesForKeysWithDictionary:value dateFormatter:dateFormatter context:context];
    }
    
    //Special cases - array relationships!
    if(!includeArrays) {
        return;
    }
    for(NSString *key in keyedValues.allKeys) {
        id value = keyedValues[key];
        if(![value isKindOfClass:[NSArray class]]) {
            continue;
        }
        
        //Got objects?
        NSArray *values = (NSArray *)value;
        if(!values.count) {
            continue;
        }
        
        if(![relationships objectForKey:key]) {
            continue;
        }
        
        //Sanity check
        if(key.length<=1) {
            continue;
        }
        
        //Classname
        NSString *className = [[key capitalizedString] substringToIndex:key.length-1];
        
        //Check classname
        if(!NSClassFromString(className)) {
            continue;
        }
        
        for(id valueDict in values) {
            //Only use dictionaries
            if(![valueDict isKindOfClass:[NSDictionary class]]) {
                break;
            }
            
            //Create and set values
            NSManagedObject *relationshipObject = [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
            [relationshipObject safeSetValuesForKeysWithDictionary:valueDict dateFormatter:dateFormatter context:context includeArrays:includeArrays];
            
            //Add it
            NSMutableSet *set = [self mutableSetValueForKey:key];
            [set addObject:relationshipObject];
        }
    }
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter context:(NSManagedObjectContext *)context
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter context:context includeArrays:FALSE];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter context:nil];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues context:(NSManagedObjectContext *)context includeArrays:(BOOL)includeArrays
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:nil context:context includeArrays:includeArrays];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues context:(NSManagedObjectContext *)context
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:nil context:context];
}

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    [self safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:nil];
}

@end
