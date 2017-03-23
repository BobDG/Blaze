//
//  BlazePageTableViewController.m
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazePageViewController.h"
#import "BlazePageTableViewController.h"

@interface BlazePageTableViewController ()

@end

@implementation BlazePageTableViewController

-(IBAction)next:(id)sender
{
    [self.pageViewController next];
}

-(IBAction)previous:(id)sender
{
    [self.pageViewController previous];
}

@end
