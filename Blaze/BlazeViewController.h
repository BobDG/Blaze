//
//  BlazeViewController.h
//  BlazeExample
//
//  Created by Bob de Graaf on 08-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewController.h"
#import "BlazeNSFetchedTableViewController.h"

@interface BlazeViewController : UIViewController
{
    
}

@property(nonatomic,strong) BlazeTableViewController *tableViewController;
@property(nonatomic,strong) BlazeNSFetchedTableViewController *fetchedTableViewController;

@end
