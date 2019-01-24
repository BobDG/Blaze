//
//  NSDateFormatter+Helper.m
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

@implementation NSDateFormatter (Helper)

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:false withLocale:[NSLocale currentLocale]];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:includeHours withLocale:[NSLocale currentLocale]];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours forceHourPadding:(BOOL)forceHourPadding
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:includeHours withLocale:[NSLocale currentLocale] timeZone:nil forceHourPadding:forceHourPadding];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours withLocale:(NSLocale *)locale
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:includeHours withLocale:locale timeZone:nil];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours timeZone:(NSTimeZone *)timeZone
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:includeHours withLocale:[NSLocale currentLocale] timeZone:timeZone  forceHourPadding:false];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours withLocale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone
{
    return [NSDateFormatter currentDateFormatterWithFormatToLocalize:format includeHours:includeHours withLocale:[NSLocale currentLocale] timeZone:timeZone forceHourPadding:false];
}

+(NSDateFormatter *)currentDateFormatterWithFormatToLocalize:(NSString *)format includeHours:(BOOL)includeHours withLocale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone forceHourPadding:(BOOL)forceHourPadding
{
    NSString *identifier = [NSString stringWithFormat:@"%@|%d|%@", format, includeHours, locale.localeIdentifier];
    if(timeZone) {
        identifier = [identifier stringByAppendingString:timeZone.abbreviation];
    }
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:identifier];
    if(dateFormatter) {
        return dateFormatter;
    }
    
    //Create it
    dateFormatter = [NSDateFormatter new];
    if(timeZone) {
        [dateFormatter setTimeZone:timeZone];
    }
    
    NSMutableString *mutableFormat = format.mutableCopy;
    [mutableFormat replaceOccurrencesOfString:@"h" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, mutableFormat.length)];
    
    if(includeHours) {
        NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:locale];
        [mutableFormat appendString:formatStringForHours];
    }
    
    // The components will be reordered according to the locale
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:mutableFormat options:0 locale:locale];
    
    if(forceHourPadding) {
        //Create copy of the parsed format
        mutableFormat = dateFormat.mutableCopy;
        
        //Separate characters
        NSMutableArray *array = [NSMutableArray new];
        [mutableFormat enumerateSubstringsInRange:NSMakeRange(0, [mutableFormat length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            [array addObject:substring];
        }] ;
        
        //Count characters
        NSCountedSet * set = [[NSCountedSet alloc] initWithArray:array];
        
        //Loop through characters we actually want in the set
        for(NSString *hourChar in @[@"h", @"H"]){
            NSUInteger count =  [set countForObject:hourChar];
            if(count == 1) {
                [mutableFormat replaceOccurrencesOfString:hourChar withString:[hourChar stringByAppendingString:hourChar] options:0 range:NSMakeRange(0, mutableFormat.length)];                
                dateFormat = mutableFormat;
            }
        }
    }
    
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

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
