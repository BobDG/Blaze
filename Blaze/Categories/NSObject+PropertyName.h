//
//  NSObject+PropertyName.h
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyName)

-(NSString *)stringForPropertyName:(SEL)propertyName;

@end