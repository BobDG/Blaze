//
//  BlazeViewController.m
//  BlazeExample
//
//  Created by Bob de Graaf on 08-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeViewController.h"

@interface BlazeViewController ()
{
    
}

@end

@implementation BlazeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[BlazeNSFetchedTableViewController class]]) {
        self.fetchedTableViewController = segue.destinationViewController;
    }
    else if([[segue destinationViewController] isKindOfClass:[BlazeTableViewController class]]) {
        self.tableViewController = segue.destinationViewController;
    }
}

@end
