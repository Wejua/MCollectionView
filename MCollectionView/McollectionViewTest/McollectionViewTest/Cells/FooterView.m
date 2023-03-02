//
//  FooterCollectionReusableView.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "FooterView.h"
#import "MCollectionView.h"
#import "FooterModel.h"

@interface FooterView()
@property (nonatomic, strong) UILabel *textL;
@end
@implementation FooterView

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

- (UILabel *)textL {
    if (!_textL) {
        _textL = [UILabel new];
        _textL.textColor = UIColor.grayColor;
        _textL.font = [UIFont systemFontOfSize:20];
        _textL.numberOfLines = 0;
        _textL.backgroundColor = UIColor.blueColor;
    }
    return _textL;
}

#pragma mark - MCollectionView
- (void)setModel_mc:(FooterModel *)model {
    self.textL.text = model.footerTitle;
}

@end
