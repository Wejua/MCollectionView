# MCollectionView

### UICollectionView的封装：
1. 自动计算行高，缓存行高
2. 支持设置cell的上下左右间隙
3. 控制器减负最有效处理，根治MVC问题。不用写数据源方法，cell的点击事件逻辑分离到各cell中，逻辑清晰，代码也不臃肿。数据源方法也不用写
4. cell中可以直接访问到CollectionView和ViewController，不用担心循环引用问题，消除一层层的代理或block传递，也不用写那么多通知

### 使用方法：
1. 初始化：
```
MCollectionView *collectionView = [[MCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical delegate:nil];
[self.view addSubview:collectionView];
```

2. cell中实现`- (void)setModel_mc:(NSObject *)model`方法设置cell数据

3. model中：实现`- (NSString *)reuseViewName_mc`方法，返回cell的类名

4. 数据源：  
```
MCollectionViewSectionModel *section1 = [MCollectionViewSectionModel new]; 
section1.itemModels = 第一组模型
section2.itemModels = 第二组模型
section3.itemModels = 第三组模型
NSMutableArray *sectionModels = [NSMutableArray arrayWithArray:@[section1, section2, section3]];
self.sectionModels = sectionModels;
```

### 完成！下面这些方法都不用写哦，控制器从此轻松了！：
```
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
```

**注：`- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath`方法也不用写，点击Cell的处理逻辑就写在Cell中。此库会调用Cell的`didSelectItem_mc`方法，并随后响应`mDelegate`的didSelectItemAtIndexPath代理方法**

