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
+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass;
+(void)copyPropertiesFrom:(id)fromObject toObject:(id)toObject;
+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass;
+(id)convertDictionaryToObject:(NSDictionary *)dictionary objectType:(Class)objectType;
+(NSMutableArray *)convertDictionaryToObjects:(NSArray *)dictionaries objectType:(Class)objectType;

@end