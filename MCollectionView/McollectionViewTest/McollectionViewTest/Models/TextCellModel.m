//
//  TextCellModel.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "TextCellModel.h"
#import "MCollectionView.h"

@implementation TextCellModel
- (NSString *)title {
    if (!_title) {
        _title = @"itemtextitemtextitemitemtextitemtextitemitemtextitemtextitemitemtextitemtextitemitemtextitemtextitemitemtextite";
    }
    return _title;
}

- (NSString *)reuseViewName_mc {
    if (self.cellType == CellType1) {
        return @"TextCell";
    } else {
        return @"TextCell2";
    }
}

- (CGSize)size_mc {
    if (self.cellType == CellType2) {
        return CGSizeMake(180, MCollectionViewAutomaticHeight);
    } else {
        return CGSizeMake(MCollectionViewAutomaticWidth, MCollectionViewAutomaticHeight);
    }
}

@end
