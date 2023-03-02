//
//  ViewController.m
//  McollectionViewTest
//
//  Created by zhouweijie1 on 2021/8/4.
//

#import "ViewController.h"
#import "MCollectionView.h"
#import "TextCell.h"
#import "TextCellModel.h"
#import "HeaderModel.h"
#import "HeaderView.h"
#import "FooterModel.h"
#import "FooterView.h"
#import "MCollectionViewSectionModel.h"

@interface ViewController ()<MCollectionViewDelegate>
@property (nonatomic, strong) MCollectionView *collectionView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray<MCollectionViewSectionModel *> *sectionModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.addButton];
    [self.view addSubview:self.deleteButton];
    [self.view addSubview:self.collectionView];
    
    [self setupData];
    self.collectionView.sectionModels = self.sectionModels;
}

//这个方法真实使用时不用，这里用来配置固定数据。真实使用的时候，字典转模型时就自动生成了模型数组，把模型数组赋值给sectionModels属性就行了
- (void)setupData {
    //section1
    NSMutableArray *section1Items = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        TextCellModel *model = [TextCellModel new];
        [section1Items addObject:model];
        if (i == 2) {
            model.layoutMargins_mc = UIEdgeInsetsMake(10, 10, 10, 10);
        }
    }
    MCollectionViewSectionModel *section1 = [MCollectionViewSectionModel new];
    section1.minimumLineSpacing = 10;
    section1.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    section1.itemModels = section1Items;
    section1.headerModel = [HeaderModel new];
    section1.footerModel = [FooterModel new];

    
    //section2
    NSMutableArray *section2items = [NSMutableArray array];
    for (NSInteger i = 0; i < 15; i++) {
        TextCellModel *textCellM =  [TextCellModel new];
        textCellM.cellType = CellType2;
        [section2items addObject:textCellM];
    }
    MCollectionViewSectionModel *section2 = [MCollectionViewSectionModel new];
    section2.minimumLineSpacing = 15;
    section2.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    section2.itemModels = section2items;
    
    
    //section3
    NSMutableArray *section3items = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        TextCellModel *textCellM =  [TextCellModel new];
        [section3items addObject:textCellM];
        if (i == 0) {
            textCellM.layoutMargins_mc = UIEdgeInsetsMake(10, 10, 10, 10);
        }
    }
    MCollectionViewSectionModel *section3 = [MCollectionViewSectionModel new];
    section3.headerModel = [HeaderModel new];
    section3.footerModel = [FooterModel new];
    section3.itemModels = section3items;

    NSMutableArray *sectionModels = [NSMutableArray arrayWithArray:@[section1, section2, section3]];
    self.sectionModels = sectionModels;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat screenW = UIApplication.sharedApplication.keyWindow.frame.size.width;
    CGFloat safeAreaTop = 0.0;
    if (@available(iOS 13.0, *)) {
        safeAreaTop = self.view.window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        safeAreaTop = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    CGFloat buttonH = 50.0;
    CGFloat buttonW = 100.0;
    CGFloat leftRigtMargin = 50.0;
    self.addButton.frame = CGRectMake(leftRigtMargin, safeAreaTop, buttonW, buttonH);
    self.deleteButton.frame = CGRectMake(screenW-leftRigtMargin-buttonW, safeAreaTop, buttonW, buttonH);
//    self.collectionView.frame = CGRectMake(0, buttonH + safeAreaTop, self.view.bounds.size.width, 200);
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.addButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
}

- (void)addItem {
    TextCellModel *textM = [TextCellModel new];
    textM.title = @"add";
    NSMutableArray *itemModels = [NSMutableArray arrayWithArray:self.sectionModels[2].itemModels];
    [itemModels insertObject:textM atIndex:0];
    self.sectionModels[2].itemModels = itemModels;
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:2]]];
}

- (void)deleteItem {
    if (self.sectionModels[2].itemModels.count > 0) {
        [self.collectionView performBatchUpdates:^{
            NSMutableArray *itemModels = [NSMutableArray arrayWithArray:self.sectionModels[2].itemModels];
            [itemModels removeObjectAtIndex:0];
            self.sectionModels[2].itemModels = itemModels;
            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:2]]];
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - MCollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldBeginMultipleSelectionInteractionAtIndexPath");
    return YES;
}

#pragma mark - lazy
- (MCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[MCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical delegate:self];
        _collectionView.backgroundColor = UIColor.lightGrayColor;
    }
    return _collectionView;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton new];
        [_addButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_addButton setTitle:@"add item" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton new];
        [_deleteButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_deleteButton setTitle:@"delete item" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
