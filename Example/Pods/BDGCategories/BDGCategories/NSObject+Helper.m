//
//  NSObject+Helper.m
//
//  Created by Bob de Graaf on 08-07-13.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <objc/runtime.h>

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

-(id)initWithDictionarySafely:(NSDictionary *)dictionary
{
    self = [self init];
    if(self) {
        [self setValuesForKeysWithDictionarySafely:dictionary];
    }
    return self;
}

+(id)convertDictionaryToObject:(NSDictionary *)dictionary objectType:(Class)objectType
{
    id object = [[objectType alloc] initWithDictionarySafely:dictionary];
    return object;
}

+(NSMutableArray *)convertDictionaryToObjects:(NSArray *)dictionaries objectType:(Class)objectType
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in dictionaries) {
        id object = [[objectType alloc] initWithDictionarySafely:dictionary];
        [returnArray addObject:object];
    }
    return returnArray;
}

-(void)setValuesForKeysWithDictionarySafely:(NSDictionary *)keyedValues
{
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        @try {
            if(obj != [NSNull null]) {
                [self setValue:obj forKey:key];
            }
        }
        @catch(NSException * e) {
            NSLog(@"Error tried to put: '%@' in a key that didn't exist:%@", obj, key);
        }
    }];
}

+(void)copyPropertiesFrom:(id)fromObject toObject:(id)toObject
{
    NSDictionary *propertyNamesDict = [fromObject PRLclassProperties];
    for(NSString *propertyName in propertyNamesDict.allKeys) {
        [toObject setValue:[fromObject valueForKey:propertyName] forKey:propertyName];
    }
}

+(id)mapObjects:(NSArray *)objects toClass:(Class)objectClass
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in objects) {
        [returnArray addObject:[self mapDictionary:dictionary toClass:objectClass]];
    }
    return returnArray;
}

+(id)mapDictionary:(NSDictionary *)dictionary toClass:(Class)objectClass
{
    id object = [[objectClass alloc] init];
    NSDictionary *objectProperties = [object PRLclassProperties];
    for(NSString *propertyName in objectProperties.allKeys) {
        //Does the dictionary contain this value
        if(!dictionary[propertyName]) {
            continue;
        }
        
        if(dictionary[propertyName] == [NSNull null]) {
            continue;
        }
        
        NSString *propertyType = objectProperties[propertyName];
        if(propertyType.length == 1 || [[propertyType substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"NS"]) {
            //Either primitive or Apple-method (assuming from a JSON dictionary you can only directly fill NS-type objects)
            [object setValue:dictionary[propertyName] forKey:propertyName];
        }
        else {
            //Custom! Let's go a level deeper then
            id customObject = [self mapDictionary:dictionary[propertyName] toClass:NSClassFromString(propertyType)];
            [object setValue:customObject forKey:propertyName];
        }
    }
    return object;
}

-(NSDictionary *)PRLclassProperties
{
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end
