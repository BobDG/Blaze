//
//  BlazePageViewController.m
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazePageViewController.h"
#import "BlazePageTableViewController.h"

@interface BlazePageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    
}

@end

@implementation BlazePageViewController

#pragma mark - View methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup
    [self setupPageController];
    
    //Setup datasource
    self.pageViewController.dataSource = self.pageControlEnabled ? self : nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Show first viewcontroller only once (not when returning)
    if(!self.pageViewController.viewControllers.count && self.viewControllers.count) {
        [self showIndex:0 direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
}

#pragma mark - Setup PageController

-(void)setupPageController
{
    if(!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.pageViewController.delegate = self;
    }
    
    if(self.containerView) {
        if(![self.pageViewController.view.superview isEqual:self.containerView]) {
            [self.pageViewController.view removeFromSuperview];
            [self.containerView addSubview:self.pageViewController.view];
            [self.pageViewController.view setBounds:self.containerView.bounds];
        }
    } else {
        if(![self.pageViewController.view.superview isEqual:self.view]) {
            [self.pageViewController.view removeFromSuperview];
            [self.view addSubview:self.pageViewController.view];
            [self.pageViewController.view setBounds:self.view.bounds];
        }
    }
}

#pragma mark - Layout

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    //Reset frame
    [self.pageViewController.view setFrame:self.containerView?self.containerView.bounds:self.view.bounds];
}

#pragma mark - Custom Getters

-(BlazePageTableViewController *)currentViewController
{
    return self.pageViewController.viewControllers.firstObject;
}

#pragma mark - Custom setters

-(void)setViewControllers:(NSArray<BlazePageTableViewController *> *)viewControllers
{
    if([_viewControllers isEqualToArray:viewControllers] && _viewControllers) {
        return;
    }
    _viewControllers = viewControllers;
}

-(void)setContainerView:(UIView *)containerView
{
    if([_containerView isEqual:containerView]) {
        return;
    }
    _containerView = containerView;
    [self setupPageController];
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if(index >= self.viewControllers.count) {
        return nil;
    }
    
    BlazePageTableViewController *viewController = self.viewControllers[index];
    viewController.pageViewController = self;
    viewController.index = index;
    return viewController;
}

-(void)next
{
    [self next:true];
}

-(void)previous
{
    [self previous:true];
}

-(void)next:(BOOL)animated
{
    if(self.viewControllers.count <= self.currentIndex+1) {
        return;
    }
    self.currentIndex++;
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:^(BOOL finished) {
        if(weakSelf.nextCompletionBlock) {
            weakSelf.nextCompletionBlock(finished);
        }
    }];
}

-(void)previous:(BOOL)animated
{
    if(self.currentIndex == 0 || self.currentIndex == NSNotFound) {
        return;
    }
    self.currentIndex--;
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:self.currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:^(BOOL finished) {
        if(weakSelf.previousCompletionBlock) {
            weakSelf.previousCompletionBlock(finished);
        }
    }];
}

-(void)showIndex:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if(index < self.viewControllers.count) {
        [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:index]] direction:direction animated:animated completion:completion];
    } else {
        if(completion) {
            completion(false);
        }
    }
}

#pragma mark - UIPageViewControllerDataSource

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.viewControllers.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.currentIndex;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if(self.currentIndex == 0 || self.currentIndex == NSNotFound) {
        return nil;
    }
    return [self viewControllerAtIndex:self.currentIndex-1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if(self.currentIndex == NSNotFound) {
        return nil;
    }
    if(self.currentIndex >= self.viewControllers.count) {
        return nil;
    }
    return [self viewControllerAtIndex:self.currentIndex+1];
}

#pragma mark - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    BlazePageTableViewController *viewController = [self.pageViewController.viewControllers lastObject];
    self.currentIndex = [self.viewControllers indexOfObject:viewController];    
}

@end














