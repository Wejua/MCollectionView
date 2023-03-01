//
//  NSObject+MCollectionView.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/5.
//

#import "MCollectionView.h"
#import <objc/runtime.h>

@implementation NSObject (MCollectionView)

- (CGSize)size_mc {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    if (!value) {
        value = @(CGSizeMake(MCollectionViewAutomaticWidth, MCollectionViewAutomaticHeight));
        objc_setAssociatedObject(self, @selector(size_mc), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [value CGSizeValue];
}

- (void)setSize_mc:(CGSize)size_mc {
    objc_setAssociatedObject(self, @selector(size_mc), @(size_mc), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)layoutMargins_mc {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    if (!value) {
        value = @(UIEdgeInsetsZero);
        objc_setAssociatedObject(self, @selector(layoutMargins_mc), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [value UIEdgeInsetsValue];
}

- (void)setLayoutMargins_mc:(UIEdgeInsets)layoutMargins_mc {
    objc_setAssociatedObject(self, @selector(layoutMargins_mc), @(layoutMargins_mc), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)cachedSize_mc {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    if (!value) {
        value = @(CGSizeZero);
        objc_setAssociatedObject(self, @selector(cachedSize_mc), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [value CGSizeValue];
}

- (void)setCachedSize_mc:(CGSize)cachedSize_mc {
    objc_setAssociatedObject(self, @selector(cachedSize_mc), @(cachedSize_mc), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)invalidateCachedSizeOnce_mc {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        number = @(false);
        objc_setAssociatedObject(self, @selector(invalidateCachedSizeOnce_mc), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [number boolValue];
}

- (void)setInvalidateCachedSizeOnce_mc:(BOOL)invalidateCachedSizeOnce_mc {
    objc_setAssociatedObject(self, @selector(invalidateCachedSizeOnce_mc), @(invalidateCachedSizeOnce_mc), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexPath_mc {
    NSIndexPath *indexPath = objc_getAssociatedObject(self, _cmd);
    if (!indexPath) {
        indexPath = [NSIndexPath indexPathWithIndex:0];
        objc_setAssociatedObject(self, @selector(indexPath_mc), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return indexPath;
}

- (void)setIndexPath_mc:(NSIndexPath *)indexPath_mc {
    objc_setAssociatedObject(self, @selector(indexPath_mc), indexPath_mc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reuseViewName_mc {
    NSString *classN = objc_getAssociatedObject(self, _cmd);
    if (!classN) {
        classN = @"";
        objc_setAssociatedObject(self, _cmd, classN, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return classN;
}

- (void)setReuseViewName_mc:(NSString *)reuseViewName_mc {
    objc_setAssociatedObject(self, @selector(reuseViewName_mc), reuseViewName_mc, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
