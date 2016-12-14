//
//  NSNumberFormatter+Helper.h
//  Pods
//
//  Created by Roy Derks on 09/11/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (Helper)

/**
 Constructs or returns an existing NSNumberFormatter with the currentLocale and DecimalStyleNone

 @return Localized NSNumberFormatter with DecimalStyleNone
 */
+(NSNumberFormatter *)currentNumberFormatterWithNoDecimals;


/**
 Constructs or returns an existing NSNumberFormatter with the currentLocale, given style and number of fractions

 @param style          NSDateFormatterStyle to use with this formatter
 @param fractionDigits The amount of fractions the formatter will use

 @return Localized NSNumberFormatter with NSNumberFormatterStyleDecimal and given amount of fractions
 */
+(NSNumberFormatter *)currentNumberFormatterWithDecimalStyle:(NSNumberFormatterStyle)style fractionDigits:(NSUInteger)fractionDigits;


/**
 Constructs or returns an existing NSNumberFormatter with the currentLocale, given style, minimum number of fractions and the maximum number of fractions.

 @param style                 NSDateFormatterStyle to use with this formatter
 @param minimumFractionDigits The minumum amount of fractions the formatter will use
 @param maximumFractionDigits The maximum amount of fractions the formatter will use

 @return Localized NSNumberFormatter with given style and the minumum and maximum amount of fractions
 */
+(NSNumberFormatter *)currentNumberFormatterWithDecimalStyle:(NSNumberFormatterStyle)style minimumFractionDigits:(NSUInteger)minimumFractionDigits maximumFractionDigits:(NSUInteger)maximumFractionDigits;


/**
 Constructs or returns an existing NSNumberFormatter with the currentLocale, NSNumberFormatterStyleDecimal, minimum number of fractions and the maximum number of fractions.
 
 @param minimumFractionDigits The minumum amount of fractions the formatter will use
 @param maximumFractionDigits The maximum amount of fractions the formatter will use

 @return Localized NSNumberFormatter with NSNumberFormatterStyleNone and the minumum and maximum amount of fractions
 */
+(NSNumberFormatter *)currentNumberFormatterWithMinimumFractionDigits:(NSUInteger)minimumFractionDigits andMaximumFractionDigits:(NSUInteger)maximumFractionDigits;

@end
