//
//  BlazeTilesCollectionView.m
//  Blaze
//
//  Created by Bob de Graaf on 07-10-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BlazeTilesCollectionView.h"
#import "BlazeTileCollectionViewCell.h"

@implementation BlazeTilesCollectionView

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Register Cells
    [self registerNib:[UINib nibWithNibName:XIBDefaultTileCollectionViewCell bundle:[NSBundle bundleForClass:NSClassFromString(XIBDefaultTileCollectionViewCell)]] forCellWithReuseIdentifier:XIBDefaultTileCollectionViewCell];
    
    return self;
}

@end
