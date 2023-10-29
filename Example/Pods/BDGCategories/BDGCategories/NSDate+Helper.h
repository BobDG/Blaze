//
//  NSDateHelper.h
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (helper)

-(NSDate *)normalizedDate;
-(NSDate *)dateByAddingDays:(NSInteger)days;
-(NSDate *)dateByAddingYears:(NSInteger)years;
-(NSDate *)dateByAddingMonths:(NSInteger)months;
-(NSInteger)numberOfDaysUntilEndDate:(NSDate *)endDate;
-(NSInteger)numberOfYearsUntilEndDate:(NSDate *)endDate;
-(NSInteger)numberOfMonthsUntilEndDate:(NSDate *)endDate;

+(BOOL)checkDateValid:(NSDate *)date;
+(BOOL)checkDateIsToday:(NSDate *)date;
+(BOOL)checkDateIsTomorrow:(NSDate *)date;
+(BOOL)checkDateIsYesterday:(NSDate *)date;
+(BOOL)checkDateIsTheSameYear:(NSDate *)date;
+(BOOL)checkDateTenMinutesLater:(NSDate *)date;
+(BOOL)checkDateTwelveHoursLater:(NSDate *)date;
+(BOOL)checkDateIsDayAfterTomorrow:(NSDate *)date;
+(BOOL)checkDateIsDayBeforeYesterday:(NSDate *)date;
+(BOOL)checkDateIsTodayIncludingNight:(NSDate *)date;
+(BOOL)checkDateLaterThan:(int)seconds withDate:(NSDate *)date;
+(BOOL)checkDateIsTheSameDay:(NSDate *)date date2:(NSDate *)date2;
+(BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;

//Time based methods
-(NSDate *)setTimeFromDate:(NSDate *)date;
+(BOOL)checkTimeIsLaterThanNow:(NSDate *)date;
+(BOOL)checkTimeIsEarlierThanNow:(NSDate *)date;
+(BOOL)checkTimeIsLater:(NSDate *)date1 thanTime:(NSDate *)date2;
+(BOOL)checkTimeIsEarlier:(NSDate *)date1 thanTime:(NSDate *)date2;

@end
