//
//  FooterModel.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "FooterModel.h"
#import "MCollectionView.h"

@implementation FooterModel

- (NSString *)footerTitle {
    return @"FooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooterFooter";
}

#pragma mark - MCollectionView
- (NSString *)reuseViewName_mc {
    return @"FooterView";
}

@end
