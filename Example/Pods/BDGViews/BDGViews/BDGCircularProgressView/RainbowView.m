//
//  RainbowView.m
//
//  Created by Bob de Graaf on 27-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RainbowView.h"
#import "AngleGradientLayer.h"

@interface RainbowView ()
{
    
}

@property(nonatomic,strong) AngleGradientLayer *angleGradientLayer;

@end

@implementation RainbowView

-(instancetype)initWithFrame:(CGRect)frame colors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations
{
    self = [self initWithFrame:frame];
    if(self) {
        self.angleGradientLayer.colors = [self convertUIColorArrayToCGColorRefArray:colors];
        self.angleGradientLayer.locations = locations;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) {
        return nil;
    }
    
    //BackgroundColor
    self.backgroundColor = [UIColor clearColor];
    
    //Get gradientlayer
    self.angleGradientLayer = (AngleGradientLayer *)self.layer;
    
    //Scale - important for non-blurriness on retina
    self.angleGradientLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //Transform
    self.angleGradientLayer.transform = CATransform3DMakeRotation(-90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
    
    return self;
}

-(NSArray*)convertUIColorArrayToCGColorRefArray:(NSArray<UIColor*>*)colors
{
    NSMutableArray *colorRefArray = [NSMutableArray new];
    for(UIColor *c in colors) {
        [colorRefArray addObject:(id)c.CGColor];
    }
    return [NSArray arrayWithArray:colorRefArray];
}

+(Class)layerClass
{
    return [AngleGradientLayer class];
}

@end






























