//
//  SCCollectionView.h
//  Hrland
//
//  Created by Tousan on 15/9/24.
//  Copyright (c) 2015年 Tousan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCollectionViewWaterFlowLayout.h"
#import "SCCollectionViewBlockLayout.h"
@class SCCollectionView;

typedef enum {
    SCCollectionViewLayoutWaterFlow = 1,
    SCCollectionViewLayoutBlock
}SCCollectionViewLayoutType;

@protocol SCCollectionViewDelegate <NSObject>

-(UICollectionViewCell*)collectionView:(SCCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
-(void)collectionView:(SCCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)collectionViewDidRefresh:(SCCollectionView *)collectionView;

@end

@interface SCCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SCCollectionViewWaterFlowLayoutDelegate>

- (id)initWithFrame:(CGRect)frame Type:(SCCollectionViewLayoutType)type;
- (void)refresh;

@property(nonatomic,assign)SCCollectionViewLayoutType type;
@property(nonatomic,assign)id<SCCollectionViewDelegate>myDelegate;
@property(nonatomic,strong)NSArray *size_Arr;
@property(nonatomic,strong)NSArray *cellInfo_Arr;
//waterflow
@property(nonatomic,assign)int col_Count;

@end
