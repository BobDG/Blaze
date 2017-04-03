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

//Possible Localizable Strings to overwrite, put here for you to easily copy :)
//"BDGImagePicker_Cancel" = "Cancel";
//"BDGImagePicker_TakePhoto" = "Take photo";
//"BDGImagePicker_ChoosePhoto" = "Choose photo";
//"Blaze_KeyboardButton_Next" = "Next";
//"Blaze_KeyboardButton_Previous" = "Previous";

@interface BlazeViewController : UIViewController
{
    
}

@property(nonatomic,strong) BlazeTableViewController *tableViewController;
@property(nonatomic,strong) BlazeNSFetchedTableViewController *fetchedTableViewController;

@end
