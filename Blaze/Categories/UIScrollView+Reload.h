//
//  UIScrollView+Reload.h
//  BDGEmptyDataSet
//
//  Created by Bob de Graaf on 6/20/14.
//  Copyright (c) 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BDGReloadDataSetDelegate;

@interface UIScrollView (Reload)

@property (nonatomic, weak) IBOutlet id <BDGReloadDataSetDelegate> reloadDataSetDelegate;

@end

@protocol BDGReloadDataSetDelegate <NSObject>
@optional

- (void)dataSetWillReload:(UIScrollView *)scrollView;

@end
