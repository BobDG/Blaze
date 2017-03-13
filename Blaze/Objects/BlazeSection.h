//
//  BlazeSection.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class BlazeRow;

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

//Collapsing
@property(nonatomic) bool collapsed;
@property(nonatomic) bool canCollapse;
@property(nonatomic,copy) void (^collapseTapped)(void);
@property(nonatomic) UITableViewRowAnimation collapseAnimation;

//Basic properties
@property(nonatomic) int ID;
@property(nonatomic,strong) NSMutableArray <BlazeRow *> *rows;
@property(nonatomic,strong) NSString *rowsXibName;
@property(nonatomic,strong) NSNumber *headerHeight;
@property(nonatomic,strong) NSNumber *footerHeight;

//Colors
@property(nonatomic,strong) UIColor *viewColor;
@property(nonatomic,strong) UIColor *backgroundColor;

//Header & Footer
@property(nonatomic,strong) NSString *buttonTitle;
@property(nonatomic,strong) NSString *headerTitle;
@property(nonatomic,strong) NSString *headerSubtitle;
@property(nonatomic,strong) NSString *footerTitle;
@property(nonatomic,strong) NSString *footerSubtitle;
@property(nonatomic,strong) NSString *headerXibName;
@property(nonatomic,strong) NSString *footerXibName;

//Custom object
@property(nonatomic,strong) id object;

//Completion blocks
@property(nonatomic,copy) void (^buttonTapped)(void);
@property(nonatomic,copy) void (^configureHeaderView)(UITableViewHeaderFooterView *headerFooterView);
@property(nonatomic,copy) void (^configureFooterView)(UITableViewHeaderFooterView *headerFooterView);

@end
