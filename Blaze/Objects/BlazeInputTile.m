//
//  BlazeInputTile.m
//  Blaze
//
//  Created by Bob de Graaf on 07-10-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BlazeInputTile.h"

@implementation BlazeInputTile

-(id)initWithID:(int)ID text:(NSString *)text tintColor:(UIColor *)tintColor baseColor:(UIColor *)baseColor imageName:(NSString *)imageName
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.text = text;
    self.tintColor = tintColor;
    self.baseColor = baseColor;
    self.imageName = imageName;
    
    return self;
}

@end
