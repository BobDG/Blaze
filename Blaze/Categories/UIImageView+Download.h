//
//  UIImageView+Download.h
//  BlazeExample
//
//  Created by Bob de Graaf on 29/10/2023.
//  Copyright © 2023 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)

-(void)setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end
