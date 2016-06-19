//
//  BlazeTableRow.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeTableRow.h"

@implementation BlazeTableRow

#pragma mark Init

-(id)initWithID:(int)ID
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    
    return self;
}

-(id)initWithID:(int)ID title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType xibName:(NSString *)xibName;
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.rowType = rowType;
    self.xibName = xibName;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType title:(NSString *)title xibName:(NSString *)xibName
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    self.xibName = xibName;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BlazeTableRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    self.value = value;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.title = title;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName title:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.xibName = xibName;
    self.segueIdentifier = segueIdentifier;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName rowType:(BlazeTableRowType)rowType
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName rowType:(BlazeTableRowType)rowType title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.title = title;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName rowType:(BlazeTableRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.title = title;
    self.rowType = rowType;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithXibName:(NSString *)xibName rowType:(BlazeTableRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.title = title;
    self.rowType = rowType;
    self.value = value;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    
    return self;
}

-(id)initWithRowType:(BlazeTableRowType)rowType
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.rowType = rowType;
    
    return self;
}

-(id)initWithRowType:(BlazeTableRowType)rowType title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithRowType:(BlazeTableRowType)rowType title:(NSString *)title value:(id)value
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.rowType = rowType;
    self.value = value;
    
    return self;
}

-(id)initWithRowType:(BlazeTableRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.rowType = rowType;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithRowType:(BlazeTableRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.rowType = rowType;
    self.value = value;
    self.placeholder = placeholder;
    
    return self;
}

#pragma mark - Object & updated

-(void)setAffectedObject:(id)affectedObject affectedPropertyName:(NSString *)affectedPropertyName
{
    self.object = affectedObject;
    self.propertyName = affectedPropertyName;
    self.value = [self.object valueForKey:self.propertyName];    
}

-(void)didUpdateValue:(id)value
{
    if(self.object && self.propertyName.length) {
        [self.object setValue:value forKey:self.propertyName];
    }
    if(self.doneChanging) {
        self.doneChanging();
    }    
}

-(void)updatedValue:(id)value
{
    if(self.object && self.propertyName.length) {
        [self.object setValue:value forKey:self.propertyName];
    }
    if(self.valueChanged) {
        self.valueChanged();
    }
}

@end
