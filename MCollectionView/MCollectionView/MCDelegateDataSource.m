//
//  MCDelegateDataSource.m
//  McollectionViewTest
//
//  Created by weijie.zhou on 2023/3/2.
//

#import "MCDelegateDataSource.h"

@implementation MCDelegateDataSource
{
    __weak MCollectionView *_collectioinView;
    __weak id<MCollectionViewDelegate> _mDelegate;
    NSMutableDictionary *_reuseViews;
    NSLayoutConstraint *_tempConstraint;
}

- (instancetype)initWithTarget:(MCollectionView *)target mDelegate:(nullable id<MCollectionViewDelegate>)mDelegate {
    if (self = [super init]) {
        _mDelegate = mDelegate;
        _reuseViews = [NSMutableDictionary dictionary];
        _collectioinView = target;
    }
    return self;
}

#pragma mark - 消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _mDelegate;
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
        return [_mDelegate respondsToSelector:aSelector];
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
    UICollectionReusableView *reuseV = [_reuseViews objectForKey:model.reuseViewName_mc ?: @""];
    if (!reuseV) {
        reuseV = [[NSClassFromString(model.reuseViewName_mc) alloc] init];
        NSAssert([reuseV isKindOfClass:UICollectionReusableView.class], @"model中reuseViewName_mc方法返回的字符串不能通过NSClassFromString方法生成UICollectionReusableView子类，请在reuseViewName_mc中返回UICollectionReusableView的子类类名");
        [_reuseViews setObject:reuseV forKey:model.reuseViewName_mc];
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
        if (_collectioinView.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            UIEdgeInsets sectionInsets = _collectioinView.sectionModels[model.indexPath_mc.section].sectionInset;
            width = _collectioinView.frame.size.width - sectionInsets.left - sectionInsets.right;
            _tempConstraint = [NSLayoutConstraint constraintWithItem:caculateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
            [caculateView addConstraint:_tempConstraint];
        } else {
            UIEdgeInsets sectionInsets = _collectioinView.sectionModels[model.indexPath_mc.section].sectionInset;
            height = _collectioinView.frame.size.height - sectionInsets.top - sectionInsets.bottom;
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
    return _collectioinView.sectionModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectioinView.sectionModels[section].itemModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *model = _collectioinView.sectionModels[indexPath.section].itemModels[indexPath.row];
    NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
    [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forCellWithReuseIdentifier:model.reuseViewName_mc];
    UICollectionViewCell *cell = [_collectioinView dequeueReusableCellWithReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
    cell.collectionView_mc = _collectioinView;
    [cell setModel_mc:model];
    cell.contentView.layoutMargins = model.layoutMargins_mc;
    return cell ?: [UICollectionViewCell new];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSObject *model = _collectioinView.sectionModels[indexPath.section].headerModel;
        NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
        [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.reuseViewName_mc];
        UICollectionReusableView *reuseV = [_collectioinView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
        reuseV.collectionView_mc = _collectioinView;
        [reuseV setModel_mc:model];
        reuseV.layoutMargins = model.layoutMargins_mc;
        return reuseV ?: [UICollectionReusableView new];
    } else {
        NSObject *model = _collectioinView.sectionModels[indexPath.section].footerModel;
        NSAssert(model.reuseViewName_mc.length, @"model中应实现reuseViewName_mc方法，返回该model对应的重用View的字符串类名，自动注册，不用使用registerClass方法注册");
        [collectionView registerClass:NSClassFromString(model.reuseViewName_mc) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:model.reuseViewName_mc];
        UICollectionReusableView *reuseV = [_collectioinView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:model.reuseViewName_mc ?: @"" forIndexPath:indexPath];
        reuseV.collectionView_mc = _collectioinView;
        [reuseV setModel_mc:model];
        reuseV.layoutMargins = model.layoutMargins_mc;
        return reuseV ?: [UICollectionReusableView new];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSObject *model = _collectioinView.sectionModels[section].headerModel;
    model.indexPath_mc = [NSIndexPath indexPathForRow:0 inSection:section];
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *model = _collectioinView.sectionModels[indexPath.section].itemModels[indexPath.item];
    model.indexPath_mc = indexPath;
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSObject *model = _collectioinView.sectionModels[section].footerModel;
    model.indexPath_mc = [NSIndexPath indexPathForRow:0 inSection:section];
    CGSize size = [self getSizeWithModel:model];
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat minimumLineSpacing = _collectioinView.sectionModels[section].minimumLineSpacing;
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat interitemSpacing = _collectioinView.sectionModels[section].minimumInteritemSpacing;
    return interitemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = _collectioinView.sectionModels[section].sectionInset;
    return insets;
}

#pragma mark - 其它要分发到cell处理的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell didSelectItem_mc];
    if ([_mDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [_mDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
