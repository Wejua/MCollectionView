//
//  MCDelegateDataSource.h
//  McollectionViewTest
//
//  Created by weijie.zhou on 2023/3/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCDelegateDataSource : NSObject<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

- (instancetype)initWithTarget:(MCollectionView *)target mDelegate:(nullable id<MCollectionViewDelegate>) mDelegate;

@end

NS_ASSUME_NONNULL_END
