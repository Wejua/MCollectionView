//
//  TextCollectionViewCell.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "TextCell.h"
#import "MCollectionView.h"
#import "TextCellModel.h"

@implementation TextCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        self.layer.borderWidth = .5;
        self.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.textL];
        
        self.textL.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:0]];
    }
    return self;
}

- (void)setModel_mc:(TextCellModel *)model {
    self.textL.text = model.title;
}

- (UILabel *)textL {
    if (!_textL) {
        _textL = [UILabel new];
        _textL.textColor = UIColor.grayColor;
        _textL.font = [UIFont systemFontOfSize:20];
        _textL.numberOfLines = 3;
        _textL.backgroundColor = UIColor.orangeColor;
    }
    return _textL;
}

- (void)didSelectItem_mc {
    NSLog(@"%@-%@", self.class, NSStringFromSelector(_cmd));
}

@end
