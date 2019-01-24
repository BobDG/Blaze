//
//  NSURL+QueryStrings.h
//  OfficeApp
//
//  Created by Bob de Graaf on 14-06-18.
//  Copyright © 2018 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryStrings)

-(NSDictionary *)getQueryStringsDictionary;

@end
