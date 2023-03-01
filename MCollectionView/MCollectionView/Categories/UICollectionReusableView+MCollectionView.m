//
//  UICollectionReusableView+MCollectionView.m
//  Mall
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "UICollectionReusableView+MCollectionView.h"
#import <objc/runtime.h>

@implementation UICollectionReusableView (MCollectionView)

- (MCollectionView *)collectionView_mc {
    _Nullable id (^block)(void) = objc_getAssociatedObject(self, _cmd);
    return (block ? block() : nil);
}

- (void)setCollectionView_mc:(MCollectionView *)collectionView_mc {
    id __weak weakObject = collectionView_mc;
    _Nullable id (^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(collectionView_mc),
                             block, OBJC_ASSOCIATION_COPY);
}

- (void)setModel_mc:(NSObject *)model {
    
}

- (void)didSelectItem_mc {
    
}

@end
