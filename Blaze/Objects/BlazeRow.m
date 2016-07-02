//
//  BlazeRow.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeRow.h"

@implementation BlazeRow

#pragma mark - Abstract constructors

+(instancetype)rowWithTitle:(NSString *)title
{
    return [[BlazeRow alloc] initWithTitle:title];
}

+(instancetype)rowWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    return [[BlazeRow alloc] initWithTitle:title segueIdentifier:segueIdentifier];
}

#pragma mark Init with ID

-(instancetype)initWithID:(int)ID
{
    return [self initWithID:ID title:nil];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title
{
    return [self initWithID:ID rowType:0 title:nil];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType
{
    return [self initWithID:ID rowType:rowType title:nil];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType xibName:(NSString *)xibName;
{
    return [self initWithID:ID rowType:rowType title:nil value:nil placeholder:nil xibName:xibName];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType title:(NSString *)title
{
    return [self initWithID:ID rowType:rowType title:title value:nil placeholder:nil];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType title:(NSString *)title xibName:(NSString *)xibName
{
    return [self initWithID:ID rowType:rowType title:title value:nil placeholder:nil xibName:xibName];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithID:ID rowType:rowType title:title value:nil placeholder:placeholder];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    return [self initWithID:ID rowType:rowType title:title value:nil placeholder:placeholder xibName:nil];
}

-(instancetype)initWithID:(int)ID rowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder xibName:(NSString *)xibName
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

#pragma mark Init with Xibname

-(instancetype)initWithXibName:(NSString *)xibName
{
    return [self initWithXibName:xibName title:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title
{
    return [self initWithXibName:xibName rowType:0 title:title];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    return [self initWithXibName:xibName rowType:0 title:title value:nil placeholder:nil segueIdentifier:segueIdentifier];
}

-(instancetype)initWithXibName:(NSString *)xibName rowType:(BlazeRowType)rowType
{
    return [self initWithXibName:xibName rowType:rowType title:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName rowType:(BlazeRowType)rowType title:(NSString *)title
{
    return [self initWithXibName:xibName rowType:rowType title:title placeholder:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName rowType:(BlazeRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithXibName:xibName rowType:rowType title:title value:nil placeholder:placeholder];
}

-(instancetype)initWithXibName:(NSString *)xibName rowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    return [self initWithXibName:xibName rowType:rowType title:title value:value placeholder:placeholder segueIdentifier:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName rowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder segueIdentifier:(NSString *)segueIdentifier
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.rowType = rowType;
    self.title = title;
    self.value = value;
    self.placeholder = placeholder;
    self.segueIdentifier = segueIdentifier;
    
    return self;
}

#pragma mark - Init with Title

-(instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title segueIdentifier:nil];
}

-(instancetype)initWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.segueIdentifier = segueIdentifier;
    
    return self;
}

#pragma mark - Init with RowType

-(instancetype)initWithRowType:(BlazeRowType)rowType
{
    return [self initWithRowType:rowType title:nil];
}

-(instancetype)initWithRowType:(BlazeRowType)rowType title:(NSString *)title
{
    return [self initWithRowType:rowType title:title value:nil];
}

-(instancetype)initWithRowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value
{
    return [self initWithRowType:rowType title:title value:value placeholder:nil];
}

-(instancetype)initWithRowType:(BlazeRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithRowType:rowType title:title value:nil placeholder:placeholder];
}

-(instancetype)initWithRowType:(BlazeRowType)rowType title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
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
