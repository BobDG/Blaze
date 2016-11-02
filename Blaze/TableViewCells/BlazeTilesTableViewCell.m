//
//  BlazeTilesTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BlazeTilesTableViewCell.h"
#import "BlazeTileCollectionViewCell.h"

@interface BlazeTilesTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    
}

@end

@implementation BlazeTilesTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(void)updateCell
{
    self.collectionView.ID = self.row.ID;
    [self.collectionView reloadData];

    if(self.row.tileSelectAutomatically) {
        [self.row updatedValue:self.row.value];
    }
    
    if(self.row.tileCellXibName.length) {
        [self.collectionView registerNib:[UINib nibWithNibName:self.row.tileCellXibName bundle:nil] forCellWithReuseIdentifier:self.row.tileCellXibName];
    }
    
    //Editable
    self.collectionView.userInteractionEnabled = !self.row.disableEditing;
}

#pragma mark - UICollectionView DataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.row.tilesValues.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BlazeTileCollectionViewCell *cell;
    if(self.row.tileCellXibName.length) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.row.tileCellXibName forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:XIBDefaultTileCollectionViewCell forIndexPath:indexPath];
    }
    NSArray *tilesArray = self.row.tilesValues;
    cell.inputTile = tilesArray[indexPath.row];
    if(self.row.tilesMultipleSelection) {
        if(![self.row.value isKindOfClass:[NSMutableArray class]]) {
            cell.selected = false;
        }
        else {
            NSUInteger idx = [self.row.value indexOfObject:@(indexPath.row)];
            if(idx != NSNotFound) {
                cell.selected = true;
            } else {
                cell.selected = false;
            }
        }
    } else {
        cell.selected = indexPath.row == [self.row.value intValue];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tilesArray = self.row.tilesValues;
    float width = collectionView.bounds.size.width;
    float tileWidth = width/tilesArray.count;
    if(tilesArray.count>self.row.tilesPerRow) {
        tileWidth = width/self.row.tilesPerRow;
    }
    float tileHeight = self.row.tileHeight;
    if(!self.row.tileHeight) {
        int totalTiles = (int)self.row.tilesValues.count;
        float totalRows = (float)totalTiles/(float)self.row.tilesPerRow;
        tileHeight = floor(collectionView.frame.size.height/(float)totalRows)-1.0f;
    }
    CGSize cellSize = CGSizeMake(floor(tileWidth), tileHeight);    
    return cellSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.row.disableEditing) {
        return;
    }
    
    NSArray *tilesArray = self.row.tilesValues;
    NSNumber *tileIndex = @(indexPath.row);
    
    if(self.row.tilesMultipleSelection) {
        if(![self.row.value isKindOfClass:[NSMutableArray class]]) {
            self.row.value = [NSMutableArray new];
        }
        
        NSUInteger idx = [self.row.value indexOfObject:tileIndex];
        if(idx != NSNotFound) {
            [self.row.value removeObjectAtIndex:idx];
        } else {
            [self.row.value addObject:tileIndex];
        }
        [self.row updatedValue:self.row.value];
        [collectionView reloadData];
    } else {
        BlazeInputTile *tile = tilesArray[indexPath.row];
        self.row.value = @(indexPath.row);
        [self.row updatedValue:self.row.value];
        for(BlazeTileCollectionViewCell *cell in collectionView.visibleCells) {
            cell.selected = cell.inputTile == tile;
        }
    }
}

@end







