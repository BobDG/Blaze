//
//  BDGTabsView.m
//  GraafICT
//
//  Created by Bob de Graaf on 16-03-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BDGTabsView.h"

@interface BDGTabsView ()
{
    
}

@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *tagLabelsArray;

@end

@implementation BDGTabsView

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Array
    self.tagLabelsArray = [NSMutableArray new];
    
    return self;
}

-(void)setTags:(NSArray *)tags
{
    //Set it
    _tags = tags;
    
    //Clear
    [self.tagLabelsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabelsArray removeAllObjects];
    
    //ScrollView
    if(!self.scrollView) {
        self.scrollView = [UIScrollView new];
        self.scrollView.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:self.scrollView];
    }
    
    //LineView
    if(!self.lineView) {
        self.lineView = [UIView new];
        self.lineView.backgroundColor = self.lineColor;
        [self.scrollView addSubview:self.lineView];
    }
    
    //Create
    for(id tag in self.tags) {
        //Create label
        UILabel *label = [UILabel new];
        label.font = self.tagFont;
        label.numberOfLines = 0;
        label.text = [self stringForTag:tag];
        label.userInteractionEnabled = TRUE;
        label.textColor = self.inactiveColor;
        label.textAlignment = NSTextAlignmentCenter;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)]];
        [self.scrollView addSubview:label];
        [self.tagLabelsArray addObject:label];
        
        if(self.cornerRadius>0) {
            label.clipsToBounds = TRUE;
            label.layer.cornerRadius = self.cornerRadius;
        }
    }
    
    //Layout
    [self layoutSubviews];
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    if(self.lineView) {
        self.lineView.backgroundColor = lineColor;
    }
}

-(void)setActiveTag:(id)activeTag
{
    _activeTag = activeTag;
    
    //Move line - update text colors
    for(int i = 0; i < self.tags.count; i++) {
        UILabel *label = self.tagLabelsArray[i];
        if(activeTag == self.tags[i]) {
            if(self.fillBackground) {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = self.activeColor;
            }
            else {
                label.textColor = self.activeColor;
            }
            float animationDuration = self.lineView.frame.size.width>0 ? 0.25f : 0.0f;
            
            //Scroll a bit if not fully visible
            float offset = self.scrollView.contentOffset.x;
            if(!self.centered && !self.disableScrolling) {
                CGRect labelFrame = label.frame;
                CGRect containerFrame = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                if(!CGRectContainsRect(containerFrame, labelFrame)) {
                    //If it's either the first or last one, simply scroll all the way - otherwise enough to see the next/previous one
                    if(labelFrame.origin.x < self.scrollView.contentOffset.x) {
                        if(i <= 1) {
                            offset = 0;
                        }
                        else {
                            offset = labelFrame.origin.x-self.paddingBetween*3;
                        }
                    }
                    else {
                        if(i >= self.tagLabelsArray.count-2) {
                            offset = self.scrollView.contentSize.width-self.scrollView.frame.size.width;
                        }
                        else {
                            offset = labelFrame.origin.x-self.scrollView.frame.size.width+labelFrame.size.width+self.paddingBetween*3;
                        }
                    }
                }
                else {
                    if(i != self.tags.count-1) {
                        if((labelFrame.origin.x-offset) > (self.scrollView.frame.size.width/2)) {
                            offset += 20.0;
                        }
                        else {
                            offset = MAX(0, offset-20);
                        }
                    }
                }
            }
            
            //Animate line/offset changes
            [UIView animateWithDuration:animationDuration animations:^{
                self.scrollView.contentOffset = CGPointMake(offset, 0);
                self.lineView.frame = CGRectMake(label.frame.origin.x, self.scrollView.frame.size.height-2, label.frame.size.width, self.lineHeight);
            }];
        }
        else {
            label.textColor = self.inactiveColor;
            label.backgroundColor = [UIColor clearColor];
        }
    }
}

-(NSString *)stringForTag:(id)tag
{
    NSString *string;
    if(self.tagPropertyName.length) {
        string = [tag valueForKey:self.tagPropertyName];
    }
    else {
        string = tag;
    }
    if(self.upperCase) {
        string = [string uppercaseString];
    }
    return string;
}

-(void)tagSelected:(UITapGestureRecognizer *)recognizer
{
    NSUInteger index = [self.tagLabelsArray indexOfObject:recognizer.view];
    self.activeTag = self.tags[index];    
    if(self.tagSelected) {
        self.tagSelected(self.tags[index]);
    }
}

#pragma mark - Layout

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //Width & height
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    //ScrollView
    self.scrollView.frame = CGRectMake(0, 0, width, height);
    
    //Tags
    if(self.disableScrolling) {
        width -= self.paddingSides*2;
        //Not scrollable, use full width divided by number of tags
        float labelWidth = width/self.tagLabelsArray.count;
        for(int i = 0; i < self.tagLabelsArray.count; i++) {
            UILabel *label = self.tagLabelsArray[i];
            labelWidth += self.paddingBetween*2;
            label.frame = CGRectMake(self.paddingSides+(i*labelWidth), 0, labelWidth, height);
        }
    }
    else if(self.centered) {
        width -= self.paddingSides*2;
        //Centered, calculate total width first
        float labelsWidth = 0;
        for(int i = 0; i < self.tagLabelsArray.count; i++) {
            UILabel *label = self.tagLabelsArray[i];
            float labelWidth = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width;
            labelsWidth += labelWidth;
        }
        //Add padding (for all labels, 1 left & 1 right)
        labelsWidth += self.tagLabelsArray.count*(self.paddingBetween*2);
        
        //Calculate start position
        float startX = width/2-labelsWidth/2;
        
        //Fix visually better-looking offset
        startX += self.paddingBetween/2;
        
        //Set frames
        for(int i = 0; i < self.tagLabelsArray.count; i++) {
            UILabel *label = self.tagLabelsArray[i];
            float labelWidth = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width;
            labelWidth += self.paddingBetween;
            label.frame = CGRectMake(startX, 0, labelWidth, height);
            labelWidth += self.paddingBetween;
            startX += labelWidth;
        }
    }
    else {
        //Scrollable - use text-width to determine size
        float x = self.paddingSides;
        for(int i = 0; i < self.tagLabelsArray.count; i++) {
            UILabel *label = self.tagLabelsArray[i];
            float labelWidth = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width;
            labelWidth += self.paddingBetween*2;
            label.frame = CGRectMake(x, 0, labelWidth, height);
            x += labelWidth;
        }
        
        //ContentSize
        self.scrollView.contentSize = CGSizeMake(x+self.paddingSides, height);
    }
    
    //Update line-frame
    if(self.activeTag) {
        self.activeTag = self.activeTag;
    }
}

@end














