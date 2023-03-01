//
//  MCollectionViewSectionModel.h
//  Mall
//
//  Created by zhouweijie1 on 2021/8/4.
//

#include <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 一个MCollectionViewSectionModel对应UICollectionView的一个组，多个代表多个组
@interface MCollectionViewSectionModel : NSObject

@property (nonatomic, strong) NSArray<NSObject *> *itemModels;

/// 设置就有header，不设置会返回[UICollectionViewCell new]，size_mc为0
@property (nonatomic, strong) NSObject *headerModel;

/// 设置就有footer，不设置会返回[UICollectionViewCell new]，size_mc为0
@property (nonatomic, strong) NSObject *footerModel;

@property (nonatomic, assign) CGFloat minimumLineSpacing;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) UIEdgeInsets sectionInset;
@end

NS_ASSUME_NONNULL_END
