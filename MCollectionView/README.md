# MCollectionView

UICollectionView的封装：
1.自动计算行高，缓存行高
2.支持设置cell的上下左右间隙
3.控制器减负最有效处理，根治MVC问题。不用写数据源方法，cell的点击事件逻辑分离到各cell中，逻辑清晰，代码也不臃肿。数据源方法也不用写
4.cell中可以直接访问到CollectionView和ViewController，不用担心循环引用问题，消除一层层的代理或block传递，也不用写那么多通知

使用方法：
1.初始化：MCollectionView *collectionView = [[MCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical delegate:nil];
        [self.view addSubview:collectionView];

2.cell中：实现- (void)setModel_mc:(NSObject *)model方法设置cell数据

3.model中：实现- (NSString *)reuseViewName_mc方法，返回cell的类名

4.设置数据：  
    MCollectionViewSectionModel *section1 = [MCollectionViewSectionModel new]; //如果要分多个组，就多初始化几个MCollectionViewSectionModel就行啦
    section1.itemModels = 模型数组

搞定了，有没有发现下面这些方法都不用写，几行代码就搞定了。用下看吧，你会发现控制器里居然空了，几千行代码秒变一百行^_^：
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout

注：- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath方法也不用写，点击Cell的处理逻辑就写在Cell中。这个方法如果有必要，写也可以，这个方法默认是Cell的didSelectItem_mc方法调用后在调用mDelegate的这个方法

