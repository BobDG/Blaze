//
//  NSObject+PropertyName.m
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "NSObject+PropertyName.h"

@implementation NSObject (PropertyName)

-(NSString *)stringForPropertyName:(SEL)propertyName
{
    return NSStringFromSelector(propertyName);
}

@end