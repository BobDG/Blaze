//
//  BlazeImagesScrollTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BlazeMediaData.h"
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
    //Row properties
    self.imageWidth = self.row.scrollImagesWidth;
    self.imagePadding = self.row.scrollImagesPadding;
    
    //Clear
    [self.imageViewsArray removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //ScrollView properties
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = FALSE;
    self.scrollView.pagingEnabled = !self.imageWidth;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    //ImageViews
    for(id imageData in self.row.scrollImages) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
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
                
            case ImageFromBlazeMediaData:
                [self updateImageView:imageView blazeMediaData:imageData];
            break;
                
            default:
                break;
        }
        [self.scrollView addSubview:imageView];
        [self.imageViewsArray addObject:imageView];
        
        if(self.row.scrollImageSelected) {
            imageView.userInteractionEnabled = TRUE;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
        }
    }
    
    //Update pagecontrol
    if(self.pageControl) {
        self.pageControl.numberOfPages = self.imageViewsArray.count;
        
        //Hide page-control possibly for only 1 image
        if(self.row.scrollImagesHidePageControlForOneImage && self.pageControl.numberOfPages<=1) {
            self.pageControl.hidden = TRUE;
        }
        else {
            self.pageControl.hidden = FALSE;
        }
    }
}

#pragma mark - Tapping

-(void)imageTapped:(UITapGestureRecognizer *)recognizer
{
    NSUInteger index = [self.imageViewsArray indexOfObject:recognizer.view];
    if(index == NSNotFound) {
        return;
    }
    if(self.row.scrollImageSelected) {
        self.row.scrollImageSelected((int)index);
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
    float imageWidth = self.imageWidth ? self.imageWidth : width;
    
    //ImageView frames
    for(int i = 0; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.frame = CGRectMake(i*(imageWidth+self.imagePadding), 0, imageWidth, height);
    }
    
    //ContentSize
    self.scrollView.contentSize = CGSizeMake(self.imageViewsArray.count*(imageWidth+self.imagePadding), height);
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.pageControl) {
        self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    }
}

@end



















































