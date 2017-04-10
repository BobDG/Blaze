//
//  BlazeInputTile.h
//  Blaze
//
//  Created by Bob de Graaf on 07-10-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BlazeInputTile : NSObject
{
    
}

-(id)initWithID:(int)ID text:(NSString *)text tintColor:(UIColor *)tintColor baseColor:(UIColor *)baseColor imageName:(NSString *)imageName;
-(id)initWithID:(int)ID name:(NSString *)name text:(NSString *)text tintColor:(UIColor *)tintColor baseColor:(UIColor *)baseColor imageName:(NSString *)imageName;

@property(nonatomic) int ID;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) UIColor *baseColor;
@property(nonatomic,strong) UIColor *tintColor;
@property(nonatomic,strong) NSString *imageName;

@end
