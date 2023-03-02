//
//  UICollectionReusableView+MCollectionView.h
//  Mall
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import <UIKit/UIKit.h>

@class MCollectionView;

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionReusableView (MCollectionView)
/// 用于在cell，header，或footer中获取UICollectionView对象
@property (nonatomic, weak) MCollectionView *collectionView_mc;

//必须实现setModel_mc方法，设置cell的数据用这个方法。影响到行高计算的逻辑都要在这个方法中执行，不然会导致自动计算行高不准确
- (void)setModel_mc:(NSObject *)model;

/// 建议在这个方法中写事件处理逻辑，而不是在ViewController中处理，需要传递参数到控制器就用viewController_mc方法获取到VC
- (void)didSelectItem_mc;

@end

NS_ASSUME_NONNULL_END
