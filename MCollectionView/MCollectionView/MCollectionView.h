//
//  MCollectionView.h
//  Mall
//
//  Created by zhouweijie1 on 2021/8/2.
//

#import <UIKit/UIKit.h>
#import "NSObject+MCollectionView.h"
#import "UICollectionReusableView+MCollectionView.h"
#import "MCollectionViewSectionModel.h"
#import "MCollectionViewDelegate.h"
#import "UIView+ViewController.h"
#import "MCDelegateDataSource.h"

static CGFloat const MCollectionViewAutomaticWidth = -1.0;
static CGFloat const MCollectionViewAutomaticHeight = -1.0;

NS_ASSUME_NONNULL_BEGIN

@interface MCollectionView : UICollectionView

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction delegate:(_Nullable id<MCollectionViewDelegate>)delegate;

/// 通过设置这个数组来控制section和item，代替UICollectionViewDelegateFlowLayout和UICollectionViewDataSource的实现
@property (nonatomic, strong) NSMutableArray<MCollectionViewSectionModel *> *sectionModels;

/// reloadItemsAtIndexPaths, reloadData, reloadSections方法调用时是否要忽略缓存大小重新计算，默认NO
@property (nonatomic, assign) BOOL invalidateCachedSizeOnReloading;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

NS_ASSUME_NONNULL_END
