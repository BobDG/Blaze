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
