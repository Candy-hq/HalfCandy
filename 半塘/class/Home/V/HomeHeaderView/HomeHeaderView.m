
//  HomeHeaderView.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeCollectionViewCell.h"
#import "HomeBanner.h"
#import "HomeListCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HomeLIst.h"

#define HMMaxSections 100


@interface HomeHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *bannerView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSUInteger pages;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initBannerView];
        [self initPageControll];
        [self addTimer];
        [self initListView];

    }
    return self;
}



-(void)setModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.bannerView reloadData];
    });
}

-(void)setListArr:(NSMutableArray *)listArr
{
    _listArr = listArr;
    [self.listView reloadData];
}

- (void)initBannerView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.width, self.height * 0.7);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.bannerView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height * 0.6) collectionViewLayout:layout];
    self.bannerView.scrollsToTop = NO;
    [self addSubview:self.bannerView];
    
    self.bannerView.showsHorizontalScrollIndicator = NO;
    self.bannerView.pagingEnabled = YES;
    self.bannerView.bounces = NO;
    self.bannerView.dataSource = self;
    self.bannerView.delegate = self;
    [self.bannerView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"pic"];
    
}
- (void)initPageControll
{
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.x = self.width * 0.5 - 50;
    self.pageControl.y = self.bannerView.height - 10;
    self.pageControl.width = 100;
    [self addSubview:self.pageControl];
}

- (void)addTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)initListView
{
    UICollectionViewFlowLayout *laout = [[UICollectionViewFlowLayout alloc]init];
    laout.itemSize = CGSizeMake(self.width * 0.3, self.width * 0.3);
    laout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 0);
    laout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.listView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, self.height * 0.6, self.width, self.height * 0.4)) collectionViewLayout:laout];
    self.listView.backgroundColor = [UIColor whiteColor];
    self.listView.scrollsToTop = NO;
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.listView];
    [self.listView registerClass:[HomeListCollectionViewCell class] forCellWithReuseIdentifier:@"list"];
}

//- (NSIndexPath *)resetIndexPath
//{
//    // 当前正在展示的位置
//    NSIndexPath *currentIndexPath = [[self.collectV indexPathsForVisibleItems] lastObject];
//    // 马上显示回最中间那组的数据
//    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:HMMaxSections/2];
//    [self.collectV scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    return currentIndexPathReset;
//}
//
- (void)autoPlay
{
//    NSIndexPath *currentIndexPath = [self.collectV indexPathsForVisibleItems].lastObject;
//    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
//   [self.collectV scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    
    
//    // 1.马上显示回最中间那组的数据
//    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
//    
//    // 2.计算出下一个需要展示的位置
//    NSInteger nextItem = currentIndexPathReset.item + 1;
//    NSInteger nextSection = currentIndexPathReset.section;
//    if (nextItem == self.modelArr.count) {
//        nextItem = 0;
//        nextSection++;
//    }
//    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
//    
//    // 3.通过动画滚动到下一个位置
//    [self.collectV scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bannerView) {
        
        NSUInteger page = (NSInteger)(scrollView.contentOffset.x / self.width + 0.5);
        self.pageControl.currentPage = page;
    }
}


#pragma mark -- collectView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.bannerView) {
        
        self.pageControl.numberOfPages = self.modelArr.count;
        return self.modelArr.count;
    }else
    {
        return self.listArr.count;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.bannerView) {
        
        HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pic" forIndexPath:indexPath];
        HomeBanner *banner = self.modelArr[indexPath.row];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:banner.photo]];
        return cell;
    }
    else
    {
        HomeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"list" forIndexPath:indexPath];
        HomeLIst *list = self.listArr[indexPath.item];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:list.pic1]];
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.listView) {
        if (indexPath.item != 0) {
            
            HomeLIst *list = self.listArr[indexPath.item];
            self.listBlock(list);
        }
    }
}
@end
