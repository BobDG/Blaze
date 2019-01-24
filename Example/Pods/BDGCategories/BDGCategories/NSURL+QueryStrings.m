//
//  NSURL+QueryStrings.m
//  OfficeApp
//
//  Created by Bob de Graaf on 14-06-18.
//  Copyright © 2018 GraafICT. All rights reserved.
//

#import "NSURL+QueryStrings.h"

@implementation NSURL (QueryStrings)

-(NSDictionary *)getQueryStringsDictionary
{
    NSString *urlStr = self.absoluteString;
    NSString *slashesCheck = @"://";
    NSUInteger slashesIndex = [urlStr rangeOfString:slashesCheck].location;
    if(slashesIndex != NSNotFound) {
        urlStr = [urlStr substringFromIndex:slashesIndex+slashesCheck.length];
    }
    
    NSString *questionmarkCheck = @"?";
    NSUInteger questionmarkIndex = [urlStr rangeOfString:questionmarkCheck].location;
    if(questionmarkIndex != NSNotFound) {
        urlStr = [urlStr substringFromIndex:questionmarkIndex+questionmarkCheck.length];
    }    
    
    NSArray *urlComponents = [urlStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    for(NSString *keyValuePair in urlComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        [queryStringDictionary setObject:value forKey:key];
    }
    return queryStringDictionary;
}

@end
