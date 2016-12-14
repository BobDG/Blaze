//
//  NSDateFormatter+Helper.m
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

@implementation NSDateFormatter (Helper)

+(NSDateFormatter *)currentDateFormatterWithFormat:(NSString*)format
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:format] ;
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [threadDictionary setObject:dateFormatter forKey:format] ;
    }
    return dateFormatter;
}

+(NSDateFormatter *)currentDateFormatterWithFormat:(NSString*)format timeZone:(NSTimeZone *)timeZone
{
    NSString *dfKey = [NSString stringWithFormat:@"%@|%@", format, timeZone.name];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:dfKey] ;
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [dateFormatter setTimeZone:timeZone];
        [threadDictionary setObject:dateFormatter forKey:dfKey] ;
    }
    return dateFormatter;
}

+(NSDateFormatter *)currentDateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle
{
    NSString *dfKey = [NSString stringWithFormat:@"%d", (int)dateStyle];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:dfKey] ;
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:dateStyle];
        [threadDictionary setObject:dateFormatter forKey:dfKey] ;
    }
    return dateFormatter;
}

+(NSDateFormatter *)currentDateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle
{
    NSString *dfKey = [NSString stringWithFormat:@"%d|%d", (int)dateStyle, (int)timeStyle];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:dfKey] ;
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:dateStyle];
        [dateFormatter setTimeStyle:timeStyle];
        [threadDictionary setObject:dateFormatter forKey:dfKey] ;
    }
    return dateFormatter;
}

@end
