//
//  TextCell2.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/24.
//

#import "TextCell2.h"

@implementation TextCell2
- (UILabel *)textL {
    UILabel *label = [super textL];
    label.numberOfLines = 0;
    return label;
}
@end
