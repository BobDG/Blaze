//
//  BlazePageViewController.m
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazePageViewController.h"
#import "BlazePageTableViewController.h"

@interface BlazePageViewController () <UIPageViewControllerDataSource>

@end

@implementation BlazePageViewController

-(instancetype)init
{
    self = [super init];
    if(self) {
        self.pageControlEnabled = false;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.pageControlEnabled = false;
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.pageControlEnabled = false;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    if(self.pageControlEnabled != true) {
        self.pageControlEnabled = false;
    }
}

-(void)setViewControllers:(NSArray<BlazePageTableViewController *> *)viewControllers
{
    if([_viewControllers isEqualToArray:viewControllers] && _viewControllers) {
        return;
    }
    _viewControllers = viewControllers;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.pageViewController.view setFrame:self.containerView?self.containerView.bounds:self.view.bounds];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPageController];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.pageViewController.viewControllers.count && self.viewControllers.count) {
        [self showIndex:0 direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setupPageController
{
    if(!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    
    if(self.containerView) {
        if([self.pageViewController.view isEqual:self.containerView]) {
            [self.pageViewController.view removeFromSuperview];
            [self.containerView addSubview:self.pageViewController.view];
            [self.pageViewController.view setBounds:self.containerView.bounds];
        }
    } else {
        if(![self.pageViewController.view isEqual:self.view]) {
            [self.pageViewController.view removeFromSuperview];
            [self.view addSubview:self.pageViewController.view];
            [self.pageViewController.view setBounds:self.view.bounds];
        }
    }
}

-(void)setContainerView:(UIView *)containerView
{
    if([_containerView isEqual:containerView]) {
        return;
    }
    _containerView = containerView;
    [self setupPageController];
}

-(void)setPageControlEnabled:(BOOL)pageControlEnabled
{
    _pageControlEnabled = pageControlEnabled;
    if(!_pageViewController) {
        [self setupPageController];
    }
    if(_pageControlEnabled) {
        self.pageViewController.dataSource = self;
    } else {
        self.pageViewController.dataSource = nil;
    }

}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if(index < self.viewControllers.count) {
        self.currentIndex = index;
        BlazePageTableViewController *viewController = self.viewControllers[index];
        viewController.pageViewController = self;
        return viewController;
    }
    return nil;
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
    
    if (self.currentIndex == 0 || self.currentIndex == NSNotFound) {
        return nil;
    }
    
    self.currentIndex++;
    return [self viewControllerAtIndex:self.currentIndex];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if(self.currentIndex == NSNotFound) {
        return nil;
    }
    
    self.currentIndex++;
    if (self.currentIndex >= [self.viewControllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:self.currentIndex];
}


@end
