//
//  SCCollectionView.m
//  Hrland
//
//  Created by Tousan on 15/9/24.
//  Copyright (c) 2015年 Tousan. All rights reserved.
//

#import "SCCollectionView.h"

@implementation SCCollectionView
{
    SCCollectionViewWaterFlowLayout *waterFlowLayout;
    SCCollectionViewBlockLayout *blockLayout;
}

- (id)initWithFrame:(CGRect)frame Type:(SCCollectionViewLayoutType)type;
{
    waterFlowLayout = [[SCCollectionViewWaterFlowLayout alloc]init];
    blockLayout = [[SCCollectionViewBlockLayout alloc]init];
    self = [super initWithFrame:frame collectionViewLayout:type==SCCollectionViewLayoutWaterFlow?waterFlowLayout:blockLayout];
    if (self)
    {
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
        _type = type;
        if (_type==SCCollectionViewLayoutWaterFlow)
        {
            waterFlowLayout.myDelegate = self;
        }
    }
    return self;
}
- (void)setCol_Count:(int)col_Count;
{
    _col_Count = col_Count;
    waterFlowLayout.col_Count = col_Count;
}
- (void)refresh;
{
    [self reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    switch (_type)
    {
        case SCCollectionViewLayoutBlock:
            return _size_Arr.count;
        case SCCollectionViewLayoutWaterFlow:
            return _size_Arr.count;
        default:
            return 0;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_type)
    {
        case SCCollectionViewLayoutBlock:
            return [_size_Arr[indexPath.item] CGSizeValue];
        case SCCollectionViewLayoutWaterFlow:
            return [_size_Arr[indexPath.item] CGSizeValue];
        default:
            return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SCCollectionViewWaterFlowLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return [_size_Arr[indexPath.item] CGSizeValue];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_myDelegate collectionView:self cellForItemAtIndexPath:indexPath];
    if (indexPath.item==_size_Arr.count-1)
    {
        CGRect self_Rect = self.frame;
        self_Rect.size.height = cell.frame.size.height+cell.frame.origin.y;
        self.frame = self_Rect;
        if (_myDelegate&&[_myDelegate respondsToSelector:@selector(collectionViewDidRefresh:)])
        {
            [_myDelegate collectionViewDidRefresh:self];
        }
    }
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = {0,0,0,0};
    return edgeInsets;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myDelegate&&[_myDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
    {
        [_myDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}
@end
