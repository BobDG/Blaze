//
//  BlazeSection.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeRow.h"
#import "BlazeSection.h"

@implementation BlazeSection

#pragma mark - Abstract constructors

+(instancetype)sectionWithHeaderTitle:(NSString *)headerTitle
{
    return [[self alloc] initWithHeaderTitle:headerTitle];
}

+(instancetype)sectionWithHeaderXibName:(NSString *)headerXibName
{
    return [[self alloc] initWithHeaderXibName:headerXibName];
}

+(instancetype)sectionWithHeaderXibName:(NSString *)headerXibName headerTitle:(NSString *)headerTitle
{
    return [[self alloc] initWithHeaderXibName:headerXibName headerTitle:headerTitle];
}

#pragma mark - Public constructors

-(id)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.rows = [[NSMutableArray alloc] init];
    
    return self;
}

-(id)initWithRowsXibName:(NSString *)rowsXibName
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.rowsXibName = rowsXibName;
    
    return self;
}

-(id)initWithHeaderXibName:(NSString *)headerXibName
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.headerXibName = headerXibName;
    
    return self;
}

-(id)initWithHeaderXibName:(NSString *)headerXibName headerTitle:(NSString *)headerTitle
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.headerTitle = headerTitle;
    self.headerXibName = headerXibName;
    
    return self;
}

-(id)initWithFooterXibName:(NSString *)footerXibName footerTitle:(NSString *)footerTitle
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.footerTitle = footerTitle;
    self.footerXibName = footerXibName;
    
    return self;
}

-(id)initWithHeaderTitle:(NSString *)headerTitle
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.headerTitle = headerTitle;
    
    return self;
}

-(id)initWithID:(int)ID title:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.headerTitle = title;
    self.backgroundColor = backgroundColor;
    
    return self;
}

-(void)addRow:(BlazeRow *)row
{
    row.section = self;
    [self.rows addObject:row];
}

@end
