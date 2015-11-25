
//
//  SearchKeyDetailView.m
//  半塘
//
//  Created by Candy on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchKeyDetailView.h"
#import "HomeListSelectView.h"
#import "SearchKeyDetailCollectionCell.h"
#import "SearchKeyDetailTableviewCell.h"
#import "UIColor+AddColor.h"
#import "UIImageView+WebCache.h"
#import "SearchData.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SearchKeyDetailView ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation SearchKeyDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initSubviews
{
    _selectView = [[HomeListSelectView alloc]initWithFrame: CGRectMake(0, 0, self.width, 40)];
    _selectView.backgroundColor = [UIColor whiteColor];
    _selectView.label_1.text = @"单品";
    _selectView.label_2.text = @"专题";
    _selectView.backgroundColor = [UIColor whiteColor];
    self.selectView = _selectView;
    [self addSubview:self.selectView];
    
  
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_selectView.x, _selectView.y + _selectView.height, self.width, self.height - _selectView.y - _selectView.height - 40)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(2 * self.width, 0);
    _scrollView.pagingEnabled = YES;
    self.scrollView = _scrollView;
    [self addSubview:self.scrollView];
    
    // collectView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.width / 2 - 10 , self.width / 2 - 10);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, _scrollView.height) collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.dataSource = self;
    _collectView.delegate = self;
    [_scrollView addSubview:_collectView];
    
    [_collectView registerClass:[SearchKeyDetailCollectionCell class] forCellWithReuseIdentifier:@"collection"];
    
    // tableView
    
    _tableView = [[UITableView alloc]initWithFrame:(CGRectMake(self.width, _collectView.y, _collectView.width, _collectView.height)) style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_scrollView addSubview:_tableView];
    
    
    __weak typeof(self) weakSelf = self;
    weakSelf.selectView.click_1 = ^{
        [weakSelf.scrollView setContentOffset:CGPointZero animated:YES];
    };
    
    weakSelf.selectView.click_2 = ^{
        [weakSelf.scrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
        
    };

}


#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collectArr.count == 0)
    {
        return 0;
    }
    return self.collectArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchKeyDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    
    if (self.collectArr.count != 0) {
        
        SearchData *data = self.collectArr[indexPath.item];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:data.pic]];
        cell.price.text = [NSString stringWithFormat:@"￥%@",data.price];
        cell.title.text = data.title;
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchData *data = self.collectArr[indexPath.item];
    NSString *str = data.ID;
    self.collectionClick(str);
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewArr.count == 0)
    {
        return 0;
    }
    return self.tableViewArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"tableview";
    SearchKeyDetailTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[SearchKeyDetailTableviewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifer];
    }
    cell.backgroundColor = [UIColor huiseColor];
    
    if (self.tableViewArr.count != 0)
    {
        SearchData *data = self.tableViewArr[indexPath.row];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:data.pic]];
        cell.title.text = data.title;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 3 + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchData *data = self.tableViewArr[indexPath.row];
    NSString *ID = data.ID;
    self.tableViewClick(ID);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.scrollView)
    {
        CGFloat x = scrollView.contentOffset.x;
        if (x == 0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.selectView.line.x = self.selectView.label_1.x;
            }];
        }
        else if (x == self.width)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.selectView.line.x = self.selectView.label_2.x;
            }];
        }
        
    }
}
@end
