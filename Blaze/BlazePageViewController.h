//
//  BlazePageViewController.h
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlazePageTableViewController;

IB_DESIGNABLE
@interface BlazePageViewController : UIViewController

@property(nonatomic,weak) IBOutlet UIView *containerView;
@property(nonatomic,strong,readonly) UIPageViewController *pageViewController;
@property(nonatomic,strong) NSArray<BlazePageTableViewController*> *viewControllers;
@property(nonatomic,strong) BlazePageTableViewController *currentViewController;
@property(nonatomic,assign) NSUInteger currentIndex;
@property(nonatomic,assign) IBInspectable BOOL pageControlEnabled;

@property(nonatomic,copy) void (^nextCompletionBlock)(BOOL finished);
@property(nonatomic,copy) void (^previousCompletionBlock)(BOOL finished);

-(BlazePageTableViewController*)viewControllerAtIndex:(NSUInteger)index;
-(void)setupPageController;
-(void)next;
-(void)next:(BOOL)animated;
-(void)showIndex:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)previous;
-(void)previous:(BOOL)animated;

@end
