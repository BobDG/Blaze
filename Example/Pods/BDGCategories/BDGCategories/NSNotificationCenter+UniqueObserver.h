//
//  NSNotificationCenter+UniqueObserver.h
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (UniqueObserver)

-(void)addUniqueObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object;

@end