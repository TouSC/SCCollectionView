//
//  SCCollectionViewWaterFlowLayout.m
//  Hrland
//
//  Created by Tousan on 15/9/24.
//  Copyright (c) 2015年 Tousan. All rights reserved.
//

#import "SCCollectionViewWaterFlowLayout.h"

@implementation SCCollectionViewWaterFlowLayout
{
    NSMutableArray *itemAtt_Arr;
    NSMutableArray *itemPoint_Arr;
    NSMutableArray *colHeight_Arr;
}

- (id)init;
{
    self = [super init];
    if (self)
    {
        itemAtt_Arr = [NSMutableArray array];
        itemPoint_Arr = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout;
{
    [super prepareLayout];
    NSInteger item_Count = [self.collectionView numberOfItemsInSection:0];
    itemAtt_Arr = [NSMutableArray arrayWithCapacity:item_Count];
    colHeight_Arr = [NSMutableArray array];
    for (int i=0; i<_col_Count; i++)
    {
        [colHeight_Arr addObject:@0];
    }
    
    for (int i=0; i<item_Count; i++)
    {
        CGSize item_Size = [self.myDelegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGPoint item_Point = CGPointZero;
        if (i<self.col_Count)
        {
            item_Point = CGPointMake(self.collectionView.frame.size.width/self.col_Count*i, 0);
            [colHeight_Arr replaceObjectAtIndex:i withObject:@(item_Size.height)];
        }
        else
        {
            float minCol_Height = 0.0;
            int minCol_Count = 0;
            for (int i=0; i<colHeight_Arr.count; i++)
            {
                if (i==0)
                {
                    minCol_Height = [colHeight_Arr[i] floatValue];
                }
                else
                {
                    if ([colHeight_Arr[i] floatValue]<minCol_Height)
                    {
                        minCol_Count = i;
                        minCol_Height = [colHeight_Arr[i] floatValue];
                    }
                }
            }
            item_Point = CGPointMake(self.collectionView.frame.size.width/self.col_Count*minCol_Count, minCol_Height);
            [colHeight_Arr replaceObjectAtIndex:minCol_Count withObject:@(minCol_Height+item_Size.height)];
        }
        
        UICollectionViewLayoutAttributes *item_Att =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        item_Att.frame = CGRectMake(item_Point.x, item_Point.y, item_Size.width, item_Size.height);
        [itemAtt_Arr addObject:item_Att];
    }
    
    float max_Height = 0.0f;
    for (int i=0; i<colHeight_Arr.count; i++)
    {
        if ([colHeight_Arr[i] floatValue]>max_Height)
        {
            max_Height = [colHeight_Arr[i] floatValue];
        }
    }
    CGRect self_Rect = self.collectionView.frame;
    self_Rect.size.height = max_Height;
    self.collectionView.frame = self_Rect;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [itemAtt_Arr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

@end

