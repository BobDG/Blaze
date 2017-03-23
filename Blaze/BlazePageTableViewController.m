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

-(void)next
{
    [self.pageViewController next];
}

-(void)previous
{
    [self.pageViewController previous];
}

@end
