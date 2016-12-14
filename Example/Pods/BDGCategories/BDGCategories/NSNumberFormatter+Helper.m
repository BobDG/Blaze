//
//  NSNumberFormatter+Helper.m
//  Pods
//
//  Created by Roy Derks on 09/11/2016.
//
//

#import "NSNumberFormatter+Helper.h"

@implementation NSNumberFormatter (Helper)

+(NSNumberFormatter *)currentNumberFormatterWithNoDecimals
{
    NSString *format = [NSString stringWithFormat:@"BDGNumberFormatter|%@", @(NSNumberFormatterNoStyle)];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSNumberFormatter *numberFormatter = [threadDictionary objectForKey:format];
    if(numberFormatter == nil)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        numberFormatter.locale = [NSLocale currentLocale];
        [threadDictionary setObject:numberFormatter forKey:format];
    }
    return numberFormatter;
}

+(NSNumberFormatter *)currentNumberFormatterWithDecimalStyle:(NSNumberFormatterStyle)style fractionDigits:(NSUInteger)fractionDigits
{
    NSString *format = [NSString stringWithFormat:@"BDGNumberFormatter|style:%@|digits:%@", @(style), @(fractionDigits)];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSNumberFormatter *numberFormatter = [threadDictionary objectForKey:format];
    if(numberFormatter == nil)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = style;
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.minimumFractionDigits = numberFormatter.maximumFractionDigits = fractionDigits;
        [threadDictionary setObject:numberFormatter forKey:format];
    }
    return numberFormatter;
}


+(NSNumberFormatter *)currentNumberFormatterWithMinimumFractionDigits:(NSUInteger)minimumFractionDigits andMaximumFractionDigits:(NSUInteger)maximumFractionDigits
{
    NSString *format = [NSString stringWithFormat:@"BDGNumberFormatter|minDigits:%@|maxDigits:%@", @(minimumFractionDigits), @(maximumFractionDigits)];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSNumberFormatter *numberFormatter = [threadDictionary objectForKey:format];
    if(numberFormatter == nil)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.minimumFractionDigits = minimumFractionDigits;
        numberFormatter.maximumFractionDigits = maximumFractionDigits;
        [threadDictionary setObject:numberFormatter forKey:format];
    }
    return numberFormatter;
}

+(NSNumberFormatter *)currentNumberFormatterWithDecimalStyle:(NSNumberFormatterStyle)style minimumFractionDigits:(NSUInteger)minimumFractionDigits maximumFractionDigits:(NSUInteger)maximumFractionDigits
{
    NSString *format = [NSString stringWithFormat:@"BDGNumberFormatter|style:%@|minDigits:%@|maxDigits:%@", @(style), @(minimumFractionDigits), @(maximumFractionDigits)];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSNumberFormatter *numberFormatter = [threadDictionary objectForKey:format];
    if(numberFormatter == nil)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = style;
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.minimumFractionDigits = minimumFractionDigits;
        numberFormatter.maximumFractionDigits = maximumFractionDigits;
        [threadDictionary setObject:numberFormatter forKey:format];
    }
    return numberFormatter;
}

@end
