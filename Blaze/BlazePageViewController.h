//
//  BlazePageViewController.h
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlazePageTableViewController;

@interface BlazePageViewController : UIViewController
{
    
}

//Outlets/Inspectables
@property(nonatomic,weak) IBOutlet UIView *containerView;

//Index
@property(nonatomic) NSUInteger currentIndex;

//PageControl
@property(nonatomic) bool pageControlEnabled;

//PageViewController/ViewControllers
@property(nonatomic,strong) UIPageViewController *pageViewController;
@property(nonatomic,strong) BlazePageTableViewController *currentViewController;
@property(nonatomic,strong) NSArray<BlazePageTableViewController*> *viewControllers;

//Callbacks
@property(nonatomic,copy) void (^nextCompletionBlock)(BOOL finished);
@property(nonatomic,copy) void (^previousCompletionBlock)(BOOL finished);

//Methods
-(void)next;
-(void)previous;
-(void)setupPageController;
-(void)next:(BOOL)animated;
-(void)previous:(BOOL)animated;
-(BlazePageTableViewController *)viewControllerAtIndex:(NSUInteger)index;
-(void)showIndex:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
