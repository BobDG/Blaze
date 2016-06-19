//
//  BlazeTableHeaderView.h
//  Blaze
//
//  Created by Bob de Graaf on 25-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlazeTableHeaderFooterView : UITableViewHeaderFooterView
{
    
}

@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UIImageView *backgroundImageView;

@end
