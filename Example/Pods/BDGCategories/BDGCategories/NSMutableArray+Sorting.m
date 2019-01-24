//
//  NSMutableArray+Sorting.m
//  OfficeApp
//
//  Created by Bob de Graaf on 22-06-18.
//  Copyright © 2018 GraafICT. All rights reserved.
//

#import "NSMutableArray+Sorting.h"

@implementation NSMutableArray (Sorting)

-(void)sortOnName:(NSString *)name
{
    [self sortOnName:name ascending:TRUE];
}

-(void)sortOnName:(NSString *)name ascending:(BOOL)ascending
{
    [self sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:name ascending:ascending]]];
}

@end
