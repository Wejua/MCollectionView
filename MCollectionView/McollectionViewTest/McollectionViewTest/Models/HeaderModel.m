//
//  HeaderModel.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "HeaderModel.h"
#import "NSObject+MCollectionView.h"

@implementation HeaderModel
- (NSString *)headerTitle {
    return @"HeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeaderHeader";
}

- (NSString *)reuseViewName_mc {
    return @"HeaderView";
}

@end
