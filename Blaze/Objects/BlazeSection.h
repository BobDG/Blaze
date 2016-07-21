//
//  BlazeSection.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BlazeSection : NSObject
{
    
}

//Constructors
-(void)addRow:(id)row;
-(id)initWithHeaderTitle:(NSString *)headerTitle;
-(id)initWithRowsXibName:(NSString *)rowsXibName;
-(id)initWithHeaderXibName:(NSString *)headerXibName headerTitle:(NSString *)headerTitle;
-(id)initWithFooterXibName:(NSString *)footerXibName footerTitle:(NSString *)footerTitle;
-(id)initWithID:(int)ID title:(NSString *)title backgroundColor:(UIColor *)backgroundColor;

//Basic properties
@property(nonatomic) int ID;
@property(nonatomic) int sectionHeight;
@property(nonatomic,strong) NSMutableArray *rows;
@property(nonatomic,strong) NSString *rowsXibName;

//Colors
@property(nonatomic,strong) UIColor *viewColor;
@property(nonatomic,strong) UIColor *backgroundColor;

//Header & Footer
@property(nonatomic,strong) NSString *headerTitle;
@property(nonatomic,strong) NSString *footerTitle;
@property(nonatomic,strong) NSString *headerXibName;
@property(nonatomic,strong) NSString *footerXibName;

//Custom object
@property(nonatomic,strong) id object;

@end