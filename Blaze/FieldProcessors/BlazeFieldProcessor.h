//
//  BlazeFieldProcessor.h
//  BlazeExample
//
//  Created by Bob de Graaf on 28-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "BlazeRow.h"
#import "BlazeTableViewCell.h"

@interface BlazeFieldProcessor : NSObject
{
    
}

-(void)update;

@property(nonatomic,strong) id field;
@property(nonatomic,strong) BlazeRow *row;
@property(nonatomic,strong) BlazeTableViewCell *cell;

@end
