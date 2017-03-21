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
    return [[self alloc] initWithTitle:title];
}

+(instancetype)rowWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    return [[self alloc] initWithTitle:title segueIdentifier:segueIdentifier];
}

#pragma mark Init with ID

-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    self.floatingLabelEnabled = FloatingLabelStateUndetermined;
    return self;
}

-(instancetype)initWithID:(int)ID
{
    return [self initWithID:ID title:nil];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title
{
    return [self initWithID:ID title:title placeholder:nil];
}

-(instancetype)initWithID:(int)ID xibName:(NSString *)xibName;
{
    return [self initWithID:ID title:nil value:nil placeholder:nil xibName:xibName];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title xibName:(NSString *)xibName
{
    return [self initWithID:ID title:title value:nil placeholder:nil xibName:xibName];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithID:ID title:title value:nil placeholder:placeholder];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    return [self initWithID:ID title:title value:nil placeholder:placeholder xibName:nil];
}

-(instancetype)initWithID:(int)ID title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder xibName:(NSString *)xibName
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.value = value;
    self.xibName = xibName;
    self.placeholder = placeholder;
    self.floatingLabelEnabled = FloatingLabelStateUndetermined;
    
    return self;
}

#pragma mark Init with Xibname

+(instancetype)rowWithXibName:(NSString *)xibName
{
    return [[self alloc] initWithXibName:xibName];
}

+(instancetype)rowWithXibName:(NSString *)xibName height:(NSNumber *)height
{
    return [[self alloc] initWithXibName:xibName height:height];
}

+(instancetype)rowWithXibName:(NSString *)xibName title:(NSString *)title
{
    return [[self alloc] initWithXibName:xibName title:title];
}

+(instancetype)rowWithXibName:(NSString *)xibName title:(NSString *)title subtitle:(NSString *)subtitle
{
    return [[self alloc] initWithXibName:xibName title:title subtitle:subtitle];
}

-(instancetype)initWithXibName:(NSString *)xibName
{
    return [self initWithXibName:xibName title:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName height:(NSNumber *)height
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.xibName = xibName;
    self.rowHeight = height;
    
    return self;
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title
{
    return [self initWithXibName:xibName title:title placeholder:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title subtitle:(NSString *)subtitle
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.xibName = xibName;
    self.subtitle = subtitle;
    self.floatingLabelEnabled = FloatingLabelStateUndetermined;
    
    return self;
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    return [self initWithXibName:xibName title:title value:nil placeholder:nil segueIdentifier:segueIdentifier];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithXibName:xibName title:title value:nil placeholder:placeholder];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder
{
    return [self initWithXibName:xibName title:title value:value placeholder:placeholder segueIdentifier:nil];
}

-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder segueIdentifier:(NSString *)segueIdentifier
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.value = value;
    self.xibName = xibName;
    self.placeholder = placeholder;
    self.segueIdentifier = segueIdentifier;
    self.floatingLabelEnabled = FloatingLabelStateUndetermined;
    
    return self;
}

#pragma mark - Init with Title

-(instancetype)initWithTitle:(NSString *)title
{
    return [self initWithtitle:title value:nil];
}

-(instancetype)initWithtitle:(NSString *)title value:(id)value
{
    return [self initWithtitle:title value:value placeholder:nil segueIdentifier:nil];
}

-(instancetype)initWithtitle:(NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithtitle:title value:nil placeholder:placeholder segueIdentifier:nil];
}

-(instancetype)initWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier
{
    return [self initWithtitle:title value:nil placeholder:nil segueIdentifier:segueIdentifier];
}

-(instancetype)initWithtitle:(NSString *)title value:(id)value placeholder:(NSString *)placeholder segueIdentifier:(NSString *)segueIdentifier
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.value = value;
    self.placeholder = placeholder;
    self.segueIdentifier = segueIdentifier;
    self.floatingLabelEnabled = FloatingLabelStateUndetermined;
    
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
    else if(self.valueChangedWithValue) {
        self.valueChangedWithValue(value);
    }
}

@end






















