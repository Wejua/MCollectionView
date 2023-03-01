//
//  MCollectionViewDelegate.h
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/23.
//

#ifndef MCollectionViewDelegate_h
#define MCollectionViewDelegate_h

/// 注：布局和数据源相关的代理方法不用实现，在MCollectionView类中处理好了，这些方法具体如下：
///- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
///- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
///- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
///- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
///- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
///- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
///- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
///- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
///- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
///- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
@protocol MCollectionViewDelegate <UICollectionViewDelegate>

@optional
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(9.0));

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath API_AVAILABLE(ios(9.0));

- (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView API_AVAILABLE(ios(14.0), tvos(10.2));

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index API_AVAILABLE(ios(14.0), tvos(10.2));

@end

#endif /* MCollectionViewDelegate_h */

