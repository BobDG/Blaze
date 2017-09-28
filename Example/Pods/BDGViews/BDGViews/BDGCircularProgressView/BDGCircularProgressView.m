//
//  BDGCircularProgressView.m
//
//  Created by Bob de Graaf on 27-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "RainbowView.h"
#import "BDGCircularProgressView.h"

static const float kDefaultAnimationDuration = 0.5f;

@interface BDGCircularProgressView ()
{
    
}

@property(nonatomic,strong) RainbowView *rainbowView;

@property(nonatomic,strong) CAShapeLayer *pathLayer;
@property(nonatomic,strong) CAShapeLayer *fullPathLayer;

@end

@implementation BDGCircularProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) {
        return nil;
    }
    
    
    //Defaults
    self.animationDuration = kDefaultAnimationDuration;
    self.trackColor = [self colorFromRGB:0xDEDEDE];

    
    //Circular properties
    self.opaque = NO;
    self.clipsToBounds = TRUE;
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = [self radiusForBounds:self.bounds];
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }

    //Defaults
    self.animationDuration = kDefaultAnimationDuration;
    self.trackColor = [self colorFromRGB:0xDEDEDE];
    
    //Circular properties
    self.opaque = NO;
    self.clipsToBounds = TRUE;
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = [self radiusForBounds:self.bounds];
    
    return self;
}

-(void)animateProgress:(float)progress fromProgress:(float)fromProgress
{
    //Progress not below 0
    progress = MAX(0, progress);
    
    //Disable previous animation
    BOOL previousDisableActionsValue = [CATransaction disableActions];
    [CATransaction setDisableActions:YES];
    
    //Animate layer
    self.pathLayer.strokeStart = progress;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnimation.duration = self.animationDuration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:fromProgress];
    pathAnimation.toValue = [NSNumber numberWithFloat:progress];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeStartAnimation"];
    
    //Fullpath strokecolor
    UIColor *strokeColor = progress < 1 ? [UIColor clearColor] : self.fullPathTrackColor?self.fullPathTrackColor:[UIColor clearColor];
    CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeAnim.fromValue         = (id) self.fullPathLayer.strokeColor;
    strokeAnim.toValue           = (id) strokeColor.CGColor;
    strokeAnim.duration          = 0.6f;
    strokeAnim.removedOnCompletion = FALSE;
    [self.fullPathLayer addAnimation:strokeAnim forKey:@"animateStrokeColor"];
    self.fullPathLayer.strokeColor = strokeColor.CGColor;
    
    //fillColor
    UIColor *fillColor = progress < 1 ? [UIColor clearColor] : self.fullPathFillColor?self.fullPathFillColor:[UIColor clearColor];
    CABasicAnimation *fillAnim = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillAnim.fromValue         = (id) self.fullPathLayer.fillColor;
    fillAnim.toValue           = (id) fillColor.CGColor;
    fillAnim.duration          = 0.6f;
    fillAnim.removedOnCompletion = FALSE;
    [self.fullPathLayer addAnimation:fillAnim forKey:@"animateFillColor"];
    self.fullPathLayer.fillColor = fillColor.CGColor;
    
    
    //Restore value
    [CATransaction setDisableActions:previousDisableActionsValue];
}

-(UIBezierPath *)circlePath
{
    CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                        radius:(CGRectGetWidth(self.bounds) / 2.0f)-2
                                                    startAngle:(3.0f * M_PI_2)
                                                      endAngle:(3.0f * M_PI_2) + (2.0f * M_PI)
                                                     clockwise:YES];
    return path;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(TARGET_OS_SIMULATOR && !self.rainbowView) {
        NSLog(@"BDGCircularProgressView initalized without setting up the RainbowView. Please use -setupRainbowViewWithColors:locations:");
    }
    
    //Rainbow
    self.rainbowView.frame = self.bounds;
    
    //Path
    self.pathLayer.path = [self circlePath].CGPath;
    self.fullPathLayer.path = self.pathLayer.path;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setupRainbowViewWithColors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations
{
    if(self.rainbowView) {
        [self.rainbowView removeFromSuperview];
        self.rainbowView = nil;
    }
    //Rainbowview
    self.rainbowView = [[RainbowView alloc] initWithFrame:self.frame colors:colors locations:locations];
    [self addSubview:self.rainbowView];
    
    //PathLayer
    self.pathLayer = [CAShapeLayer new];
    self.pathLayer.lineWidth = 4.5f;
    self.pathLayer.strokeStart = 0.0f;
    self.pathLayer.strokeEnd = 1.0f;
    self.pathLayer.strokeColor = self.trackColor.CGColor;
    self.pathLayer.fillColor = [UIColor clearColor].CGColor;
    self.pathLayer.path = [self circlePath].CGPath;
    [self.layer addSublayer:self.pathLayer];
    
    //FullPathLayer
    self.fullPathLayer = [CAShapeLayer new];
    self.fullPathLayer.lineWidth = 4.5f;
    self.fullPathLayer.strokeStart = 0.0f;
    self.fullPathLayer.strokeEnd = 1.0f;
    self.fullPathLayer.strokeColor = [UIColor clearColor].CGColor;
    self.fullPathLayer.fillColor = [UIColor clearColor].CGColor;
    self.fullPathLayer.path = self.pathLayer.path;
    [self.layer addSublayer:self.fullPathLayer];
    [self layoutSubviews];
}

-(UIColor *)colorFromRGB:(unsigned)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

-(void)setBounds:(CGRect)bounds
{
    self.layer.cornerRadius = [self radiusForBounds:bounds];
    [super setBounds:bounds];
}

-(CGFloat)radiusForBounds:(CGRect)bounds
{
    return fminf(bounds.size.width, bounds.size.height) / 2;
}

-(void)prepareForInterfaceBuilder
{
    [self awakeFromNib];
    [self layoutSubviews];
}

@end
