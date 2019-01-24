//
//  UIImage+UIImage_Helper.h
//
//  Created by Bob de Graaf on 01-02-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Helper)

+(UIImage *)imageNamed:(NSString *)name deviceSpecific:(BOOL)deviceSpecific extension:(NSString *)extension;
-(UIImage *)fixOrientation;
-(UIImage *)blurredImage:(CGFloat)blurAmount;
-(UIImage *)cropToRect:(CGRect)rect;
-(UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
-(UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
-(UIImage *)imageByScalingToSize:(CGSize)targetSize;
-(UIImage *)imageRotatedByRadians:(CGFloat)radians;
-(UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


@end
