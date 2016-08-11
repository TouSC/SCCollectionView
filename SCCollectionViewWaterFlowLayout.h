//
//  SCCollectionViewWaterFlowLayout.h
//  Hrland
//
//  Created by Tousan on 15/9/24.
//  Copyright (c) 2015年 Tousan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCCollectionViewWaterFlowLayout;
@protocol SCCollectionViewWaterFlowLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView
                   layout:(SCCollectionViewWaterFlowLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SCCollectionViewWaterFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,strong)id<SCCollectionViewWaterFlowLayoutDelegate>myDelegate;
@property(nonatomic,assign)int col_Count;

@end
