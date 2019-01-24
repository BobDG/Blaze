//
//  NSMutableArray+Sorting.h
//  OfficeApp
//
//  Created by Bob de Graaf on 22-06-18.
//  Copyright © 2018 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Sorting)

-(void)sortOnName:(NSString *)name;
-(void)sortOnName:(NSString *)name ascending:(BOOL)ascending;

@end
