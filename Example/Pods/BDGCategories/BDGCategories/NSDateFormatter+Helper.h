//
//  NSDateFormatter+Helper.h
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Helper)
{
    
}

+(NSDateFormatter *)currentDateFormatterWithFormat:(NSString*)format;
+(NSDateFormatter *)currentDateFormatterWithFormat:(NSString*)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)currentDateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle;
+(NSDateFormatter *)currentDateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle;

@end
