//
//  EmptyStateTableViewController.m
//  Example
//
//  Created by Bob de Graaf on 12-06-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "EmptyStateTableViewController.h"

@interface EmptyStateTableViewController ()

@end

@implementation EmptyStateTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Empty state
    self.emptyImage = [UIImage imageNamed:@"Blaze_Logo"];
    self.emptyBackgroundColor = [UIColor whiteColor];
    self.emptyVerticalOffset = -100.0f;
    self.emptyTitle = @"This is an example text for an empty state, you can provide colors, atributed text, image, background color, etc.\nCredits to DZNEmptyDataSet!";
    self.emptyTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f weight:UIFontWeightLight], NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    
    
    
    //Empty state custom view with hitTest for UIButton subview
/*
    self.emptyBackgroundColor = [UIColor redColor];
    UIView *view = [UIView new];
    self.emptyVerticalOffset = -300.0f;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 250, 50)];
    lbl.text = @"Custom label!";
    lbl.backgroundColor = [UIColor yellowColor];
    [view addSubview:lbl];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 0, 200, 200);
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"HitTest" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    self.emptyCustomView = view;
 */
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Floating action button
    __weak __typeof(self)weakSelf = self;
    [self setupFloatingActionButtonWithImage:[UIImage imageNamed:@"Button_FAB_Red"] padding:32.0f tapped:^{
        [weakSelf actionButtonTapped];
    } animated:TRUE];
}

-(void)actionButtonTapped
{
    NSLog(@"Action button tapped!");
}

-(void)buttonTapped:(UIButton*)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Button", @"") message:NSLocalizedString(@"Tapped", @"") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:TRUE completion:^{
        
    }];
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}

@end
