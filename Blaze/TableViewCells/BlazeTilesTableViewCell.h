//
//  BlazeTilesTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlazeTableViewCell.h"
#import "BlazeTilesCollectionView.h"

@interface BlazeTilesTableViewCell : BlazeTableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>
{
    
}

@property(nonatomic,weak) IBOutlet BlazeTilesCollectionView *collectionView;

@end
