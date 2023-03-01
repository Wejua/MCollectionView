//
//  NSObject+MCollectionView.h
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MCollectionView)

///必须重写这个方法，通过这个方法返回的字符串注册重用视图。通过NSClassFromString()初始化视图，所以这个方法必须返回真实类名
@property (nonatomic, copy) NSString *reuseViewName_mc;

/// 重写这个方法返回cell，header，footer的大小。不重写时高度是自动计算的，值为CGSizeMake(UIScreen.mainScreen.bounds.size.width, MCollectionViewAutomaticHeight)
@property (nonatomic, assign) CGSize size_mc;

/// 使size_mc计算出的大小失效一次，重新计算大小，不使用缓存大小
@property (nonatomic, assign) BOOL invalidateCachedSizeOnce_mc;

/// 上下左右间隙，这个值有效的前提是编写约束时使用带Margin的约束，如：[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];用的是NSLayoutAttributeTopMargin，而不是NSLayoutAttributeTop。McollectionViewTest项目中使用的就是NSLayoutAttributeTopMargin
@property (nonatomic, assign) UIEdgeInsets layoutMargins_mc;

/// 用于存储缓存大小
@property (nonatomic, assign) CGSize cachedSize_mc;

/// 用于记录cell，header，footer的indexPath。
@property (nonatomic, strong) NSIndexPath *indexPath_mc;
@end

NS_ASSUME_NONNULL_END
