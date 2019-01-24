//
//  NSObject+Helper.h
//
//  Created by Bob de Graaf on 08-07-13.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)

//Public methods
-(NSDictionary *)PRLclassProperties;
-(id)initWithDictionarySafely:(NSDictionary *)dictionary;
-(void)setValuesForKeysWithDictionarySafely:(NSDictionary *)keyedValues;

//Class methods
+(void)copyPropertiesFrom:(id)fromObject toObject:(id)toObject;
+(id)convertDictionaryToObject:(NSDictionary *)dictionary objectType:(Class)objectType;
+(NSMutableArray *)convertDictionaryToObjects:(NSArray *)dictionaries objectType:(Class)objectType;

//Mapping array of objects
+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass;
+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter;
+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary;
+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary arrayMappingDictionary:(NSDictionary *)arrayMappingDictionary;

//Mapping one object
+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass;
+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter;
+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary;
+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary arrayMappingDictionary:(NSDictionary *)arrayMappingDictionary;

@end
