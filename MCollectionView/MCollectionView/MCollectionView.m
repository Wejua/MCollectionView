//
//  MCollectionView.m
//  Mall
//
//  Created by zhouweijie1 on 2021/8/2.
//

#import "MCollectionView.h"

@implementation MCollectionView
{
    MCDelegateDataSource *_delegateDataSource;
    __weak id<MCollectionViewDelegate> _mDelegate;
}

#pragma mark - 公有方法
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction delegate:(_Nullable id<MCollectionViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    if (self) {
        self.flowLayout.scrollDirection = direction;
        _mDelegate = delegate;
        _delegateDataSource = [[MCDelegateDataSource alloc] initWithTarget:self mDelegate:_mDelegate];
        self.delegate = _delegateDataSource;
        self.dataSource = _delegateDataSource;
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

#pragma mark - setter
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    NSAssert(delegate == _delegateDataSource || delegate == nil, @"请使用mDelegate, 在初始化MCollectionView时给定");
    [super setDelegate:delegate];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    NSAssert(dataSource == _delegateDataSource || dataSource == nil, @"请使用mDelegate，在初始化MCollectionView时给定");
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

@end
