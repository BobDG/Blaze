//
//  BlazeImagesScrollTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeImagesScrollTableViewCell.h"

@interface BlazeImagesScrollTableViewCell () <UIScrollViewDelegate>
{
    
}

@property(nonatomic,strong) NSMutableArray *imageViewsArray;

@end

@implementation BlazeImagesScrollTableViewCell

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Create array
    self.imageViewsArray = [NSMutableArray new];
    
    return self;
}

-(void)updateCell
{
    //Clear
    [self.imageViewsArray removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //ScrollView properties
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = TRUE;
    self.scrollView.pagingEnabled = TRUE;
    self.scrollView.scrollsToTop = FALSE;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    //ImageViews
    for(id imageData in self.row.scrollImages) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        if(self.row.scrollImageContentMode != UIViewContentModeScaleToFill) {
            imageView.contentMode = self.row.scrollImageContentMode;
        }
        imageView.clipsToBounds = TRUE;
        switch (self.row.scrollImageType) {
            case ImageFromURL:
                [self updateImageView:imageView imageURLString:imageData];
                break;
            case ImageFromBundle:
                [self updateImageView:imageView imageName:imageData];
                break;
            
            case ImageFromData:
                [self updateImageView:imageView imageData:imageData];
            break;
                
            default:
                break;
        }
        [self.scrollView addSubview:imageView];
        [self.imageViewsArray addObject:imageView];
    }
    
    //Update pagecontrol
    if(self.pageControl) {
        self.pageControl.numberOfPages = self.imageViewsArray.count;
    }
}

#pragma mark Layout

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateImageViewFrames];
}
                                  
-(void)updateImageViewFrames
{
    //Width & height
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    //ImageView frames
    for(int i = 0; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.frame = CGRectMake(i*width, 0, width, height);
    }
    
    //ContentSize
    self.scrollView.contentSize = CGSizeMake(self.imageViewsArray.count*width, height);
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.pageControl) {
        self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    }
}

@end



















































