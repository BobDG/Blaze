//
//  BlazePageTableViewController.h
//  BlazeExample
//
//  Created by Roy Derks on 23/03/2017.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeTableViewController.h"

@class BlazePageViewController;

@interface BlazePageTableViewController : BlazeTableViewController
{
    
}

@property(nonatomic) NSUInteger index;
@property(nonatomic,strong) BlazePageViewController *pageViewController;

-(void)next;
-(void)previous;

@end
