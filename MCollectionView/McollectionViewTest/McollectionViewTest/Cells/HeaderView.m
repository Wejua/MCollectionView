//
//  HeaderView.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "HeaderView.h"
#import "HeaderModel.h"
#import "MCollectionView.h"

@interface HeaderView()
@property (nonatomic, strong) UILabel *textL;
@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.textL];
        self.textL.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:-0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textL attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:-0]];
    }
    return self;
}

- (void)setModel_mc:(HeaderModel *)model {
    self.textL.text = model.headerTitle;
}

- (UILabel *)textL {
    if (!_textL) {
        _textL = [UILabel new];
        _textL.textColor = UIColor.blueColor;
        _textL.font = [UIFont systemFontOfSize:20];
        _textL.numberOfLines = 0;
        _textL.backgroundColor = UIColor.grayColor;
    }
    return _textL;
}
@end
