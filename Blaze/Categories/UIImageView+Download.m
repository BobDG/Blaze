//
//  UIImageView+Download.m
//  BlazeExample
//
//  Created by Bob de Graaf on 29/10/2023.
//  Copyright © 2023 GraafICT. All rights reserved.
//


#import "UIImageView+Download.h"

@implementation UIImageView (Download)

-(void)setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
{
    [self setImage:placeholderImage];
    [self loadImage:[NSURL URLWithString:urlString]];
}

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];

    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)image
{
    [self setImage:image];
}

@end
