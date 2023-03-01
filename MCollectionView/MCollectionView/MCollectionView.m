//
//  MCollectionView.m
//  Mall
//
//  Created by zhouweijie1 on 2021/8/2.
//

#import "MCollectionView.h"
#include <objc/runtime.h>

typedef enum : NSUInteger {
    MCollectionViewTypeCell,
    MCollectionViewTypeHeader,
    MCollectionViewTypeFooter,
} MCollectionViewType;

@interface MCollectionView()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *reuseViews;
@end
@implementation MCollectionView
{
    CGSize _automaticSize;
    NSLayoutConstraint *_tempConstraint;
}

#pragma mark - 公有方法
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction delegate:(_Nullable id<MCollectionViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    if (self) {
        self.flowLayout.scrollDirection = direction;
        self.mDelegate = delegate;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)reloadSections:(NSIndexSet *)sections {
    if (self.invalidateCachedSizeOnReloading) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            self.sectionModels[idx].headerModel.invalidateCachedSizeOnce_mc = YES;
            self.sectionModels[idx].footerModel.invalidateCachedSizeOnce_mc = YES;
            for (NSObject *itemM in self.sectionModels[idx].itemModels) {
                itemM.invalidateCachedSizeOnce_mc = YES;
            }
        }];
    }
    [super reloadSections:sections];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (self.invalidateCachedSizeOnReloading) {
        for (NSIndexPath *indexPath in indexPaths) {
            self.sectionModels[indexPath.section].itemModels[indexPath.item].invalidateCachedSizeOnce_mc = YES;
        }
    }
    [super reloadItemsAtIndexPaths:indexPaths];
}

- (void)reloadData {
    if (self.invalidateCachedSizeOnReloading) {
        [self.sectionModels enumerateObjectsUsingBlock:^(MCollectionViewSectionModel * _Nonnull sectionM, NSUInteger idx, BOOL * _Nonnull stop) {
            sectionM.headerModel.invalidateCachedSizeOnce_mc = YES;
            sectionM.footerModel.invalidateCachedSizeOnce_mc = YES;
            [sectionM.itemModels enumerateObjectsUsingBlock:^(NSObject * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                model.invalidateCachedSizeOnce_mc = YES;
            }];
        }];
    }
    [super reloadData];
}

#pragma mark - 消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.mDelegate;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if(
        aSelector == @selector(collectionView:canMoveItemAtIndexPath:) ||
        aSelector == @selector(collectionView:moveItemAtIndexPath:toIndexPath:) ||
        aSelector == @selector(indexTitlesForCollectionView:) ||
        aSelector == @selector(collectionView:indexPathForIndexTitle:atIndex:) ||
        aSelector == @selector(collectionView:shouldHighlightItemAtIndexPath:) ||
        aSelector == @selector(collectionView:didHighlightItemAtIndexPath:) ||
        aSelector == @selector(collectionView:didUnhighlightItemAtIndexPath:) ||
        aSelector == @selector(collectionView:shouldSelectItemAtIndexPath:) ||
        aSelector == @selector(collectionView:shouldDeselectItemAtIndexPath:) ||
//        aSelector == @selector(collectionView:didSelectItemAtIndexPath:) || //分发到cell处理
        aSelector == @selector(collectionView:didDeselectItemAtIndexPath:) ||
        aSelector == @selector(collectionView:canPerformPrimaryActionForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:performPrimaryActionForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:willDisplayCell:forItemAtIndexPath:) ||
        aSelector == @selector(collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:) ||
        aSelector == @selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:) ||
        aSelector == @selector(collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:) ||
        aSelector == @selector(collectionView:shouldShowMenuForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:canPerformAction:forItemAtIndexPath:withSender:) ||
        aSelector == @selector(collectionView:performAction:forItemAtIndexPath:withSender:) ||
        aSelector == @selector(collectionView:transitionLayoutForOldLayout:newLayout:) ||
        aSelector == @selector(collectionView:canFocusItemAtIndexPath:) ||
        aSelector == @selector(collectionView:shouldUpdateFocusInContext:) ||
        aSelector == @selector(collectionView:didUpdateFocusInContext:withAnimationCoordinator:) ||
        aSelector == @selector(indexPathForPreferredFocusedViewInCollectionView:) ||
        aSelector == @selector(collectionView:selectionFollowsFocusForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:targetIndexPathForMoveOfItemFromOriginalIndexPath:atCurrentIndexPath:toProposedIndexPath:) ||
        aSelector == @selector(collectionView:targetIndexPathForMoveFromItemAtIndexPath:toProposedIndexPath:) ||
        aSelector == @selector(collectionView:targetContentOffsetForProposedContentOffset:) ||
        aSelector == @selector(collectionView:canEditItemAtIndexPath:) ||
        aSelector == @selector(collectionView:shouldSpringLoadItemAtIndexPath:withContext:) ||
        aSelector == @selector(collectionView:shouldBeginMultipleSelectionInteractionAtIndexPath:) ||
        aSelector == @selector(collectionView:didBeginMultipleSelectionInteractionAtIndexPath:) ||
        aSelector == @selector(collectionViewDidEndMultipleSelectionInteraction:) ||
        aSelector == @selector(collectionView:contextMenuConfigurationForItemsAtIndexPaths:point:) ||
        aSelector == @selector(collectionView:contextMenuConfiguration:highlightPreviewForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:contextMenuConfiguration:dismissalPreviewForItemAtIndexPath:) ||
        aSelector == @selector(collectionView:willPerformPreviewActionForMenuWithConfiguration:animator:) ||
        aSelector == @selector(collectionView:willDisplayContextMenuWithConfiguration:animator:) ||
        aSelector == @selector(collectionView:willEndContextMenuInteractionWithConfiguration:animator:) ||
        aSelector == @selector(collectionView:sceneActivationConfigurationForItemAtIndexPath:point:) ||
        aSelector == @selector(collectionView:contextMenuConfigurationForItemAtIndexPath:point:) ||
        aSelector == @selector(collectionView:previewForHighlightingContextMenuWithConfiguration:) ||
        aSelector == @selector(collectionView:previewForDismissingContextMenuWithConfiguration:) ||
        aSelector == @selector(scrollViewDidScroll:) ||
        aSelector == @selector(scrollViewDidZoom:) ||
        aSelector == @selector(scrollViewWillBeginDragging:) ||
        aSelector == @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:) ||
        aSelector == @selector(scrollViewDidEndDragging:willDecelerate:) ||
        aSelector == @selector(scrollViewWillBeginDecelerating:) ||
        aSelector == @selector(scrollViewDidEndDecelerating:) ||
        aSelector == @selector(scrollViewDidEndScrollingAnimation:) ||
        aSelector == @selector(viewForZoomingInScrollView:) ||
        aSelector == @selector(scrollViewWillBeginZooming:withView:) ||
        aSelector == @selector(scrollViewDidEndZooming:withView:atScale:) ||
        aSelector == @selector(scrollViewShouldScrollToTop:) ||
        aSelector == @selector(scrollViewDidScrollToTop:) ||
        aSelector == @selector(scrollViewDidChangeAdjustedContentInset:)
        ) {
        return [self.mDelegate respondsToSelector:aSelector];
    } else {
        return [super respondsToSelector:aSelector];
    }
}

#pragma mark - 私有方法
- (CGSize)getSizeWithModel:(NSObject *)model {
    if (!model) {
        return CGSizeZero;
    }
    if (!model.invalidateCachedSizeOnce_mc && !CGSizeEqualToSize(model.cachedSize_mc, CGSizeZero)) return model.cachedSize_mc;
    CGSize size = [model size_mc];
    if (size.width == MCollectionViewAutomaticWidth || size.height == MCollectionViewAutomaticHeight) {
        size = [self caculateSizeWithWidth:size.width height:size.height model:model];
    }
    model.cachedSize_mc = size;
    model.invalidateCachedSizeOnce_mc = false;
    return size;
}

- (CGSize)caculateSizeWithWidth:(CGFloat)width height:(CGFloat)height model:(NSObject *)model {
    UICollectionReusableView *reuseV = [self.reuseViews objectForKey:model.reuseViewName_mc ?: @""];
    if (!reuseV) {
        reuseV = [[NSClassFromString(model.reuseViewName_mc) alloc] init];
        NSAssert([reuseV isKindOfClass:UICollectionReusableView.class], @"model中reuseViewName_mc方法返回的字符串不能通过NSClassFromString方法生成UICollectionReusableView子类，请在reuseViewName_mc中返回UICollectionReusableView的子类类名");
        [self.reuseViews setObject:reuseV forKey:model.reuseViewName_mc];
    }
    [reuseV setModel_mc:model];
    UIView *caculateView;
    if ([reuseV isKindOfClass:UICollectionViewCell.class]) {
        UICollectionViewCell *cellV = (UICollectionViewCell *)reuseV;
        caculateView = cellV.contentView;
    } else {
        caculateView = reuseV;
    }
    caculateView.layoutMargins = model.layoutMargins_mc;
    if (width != MCollectionViewAutomaticWidth) {
        _tempConstraint = [NSLayoutConstraint constraintWithItem:caculateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
        [caculateView addConstraint:_tempConstraint];
        
    } else if (height != MCollectionViewAutomaticHeight) {
        _tempConstraint = [NSLayoutConstraint constraintWithItem:caculateView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
        [caculateView addConstraint:_tempConstraint];
    } else if (width == MCollectionViewAutomaticWidth && height == MCollectionViewAutomaticHeight) {
        if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            UIEdgeInsets sectionInsets = self.sectionModels[model.indexPath_mc.section].sectionInset;
            width = self.frame.size.width - sectionInsets.left - sectionInsets.right;
            _tempConstraint = [NSLayoutConstraint constraintWithItem:caculateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
            [caculateView addConstraint:_tempConstraint];
        } else {
            UIEdgeInsets sectionInsets = self.sectionModels[model.indexPath_mc.section].sectionInset;
            height = self.frame.size.height - sectionInsets.top - sectionInsets.bottom;
            _tempConstraint = [NSLayoutConstraint constraintWithItem:caculateView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
            [caculateView addConstraint:_tempConstraint];
        }
    }
    CGSize size = [caculateView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [caculateView removeConstraint:_tempConstraint];
    _tempConstraint = nil;
    return size;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sectionModels[section].itemModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *model = self.sectionModels[indexPath.section].itemModels[indexPath.row];
    NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
    [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forCellWithReuseIdentifier:model.reuseViewName_mc];
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
    cell.collectionView_mc = self;
    [cell setModel_mc:model];
    cell.contentView.layoutMargins = model.layoutMargins_mc;
    return cell ?: [UICollectionViewCell new];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSObject *model = self.sectionModels[indexPath.section].headerModel;
        NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
        [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.reuseViewName_mc];
        UICollectionReusableView *reuseV = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
        reuseV.collectionView_mc = self;
        [reuseV setModel_mc:model];
        reuseV.layoutMargins = model.layoutMargins_mc;
        return reuseV ?: [UICollectionReusableView new];
    } else {
        NSObject *model = self.sectionModels[indexPath.section].footerModel;
        NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
        [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:model.reuseViewName_mc];
        UICollectionReusableView *reuseV = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
        reuseV.collectionView_mc = self;
        [reuseV setModel_mc:model];
        reuseV.layoutMargins = model.layoutMargins_mc;
        return reuseV ?: [UICollectionReusableView new];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSObject *model = self.sectionModels[section].headerModel;
    model.indexPath_mc = [NSIndexPath indexPathForRow:0 inSection:section];
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *model = self.sectionModels[indexPath.section].itemModels[indexPath.item];
    model.indexPath_mc = indexPath;
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSObject *model = self.sectionModels[section].footerModel;
    model.indexPath_mc = [NSIndexPath indexPathForRow:0 inSection:section];
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat minimumLineSpacing = self.sectionModels[section].minimumLineSpacing;
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat interitemSpacing = self.sectionModels[section].minimumInteritemSpacing;
    return interitemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = self.sectionModels[section].sectionInset;
    return insets;
}

#pragma mark - 其它要分发到cell处理的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell didSelectItem_mc];
    if ([self.mDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.mDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - setter
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    NSAssert(delegate == self || delegate == nil, @"请使用mDelegate");
    [super setDelegate:delegate];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    NSAssert(dataSource == self || dataSource == nil, @"请使用mDelegate");
    [super setDataSource:dataSource];
}

#pragma mark - 懒加载
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionHeadersPinToVisibleBounds = true;
        _flowLayout.sectionFootersPinToVisibleBounds = true;
    }
    return _flowLayout;
}

- (NSMutableDictionary *)reuseViews {
    if (!_reuseViews) {
        _reuseViews = [NSMutableDictionary dictionary];
    }
    return _reuseViews;
}

@end
