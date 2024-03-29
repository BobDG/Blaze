//
//  BlazeInputProcessor.h
//  BlazeExample
//
//  Created by Bob de Graaf on 28-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "BlazeRow.h"
#import "BlazeTableViewCell.h"

@interface BlazeInputProcessor : NSObject
{
    
}

-(void)update;
-(BOOL)canBecomeFirstResponder;

@property(nonatomic,strong) id input;
@property(nonatomic,weak) BlazeRow *row;
@property(nonatomic,weak) BlazeTableViewCell *cell;

@end
