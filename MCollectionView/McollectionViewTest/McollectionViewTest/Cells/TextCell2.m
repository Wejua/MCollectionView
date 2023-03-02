//
//  TextCell2.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/24.
//

#import "TextCell2.h"
#import "TextCellModel.h"
#import "MCollectionView.h"

@implementation TextCell2

- (UILabel *)textL {
    UILabel *label = [super textL];
    label.numberOfLines = 0;
    return label;
}

#pragma mark - MCollectionView
- (void)setModel_mc:(TextCellModel *)model {
    self.textL.text = model.title;
}

- (void)didSelectItem_mc {
    NSLog(@"\nviewController: %@, \ncollectinView: %@, \nindexPath: %@, \nclass: %@, \nSelector: %@",NSStringFromClass(self.viewController_mc.class) ,NSStringFromClass(self.collectionView_mc.class), self.indexPath_mc, self.class, NSStringFromSelector(_cmd));
}

@end
