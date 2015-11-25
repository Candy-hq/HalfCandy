//
//  SearchGoodsDetailViewController.m
//  半塘
//
//  Created by Candy on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchGoodsDetailViewController.h"
#import "SearchKeyDetailCollectionCell.h"
#import "SearchGoodsHeaderView.h"
#import "HomeProject.h"
#import "AFNetworkTool.h"
#import "SearchData.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"
#import "SearchGoodsTopicCell.h"
#import "MBProgressHUD.h"

#define kURL @"http://open3.bantangapp.com/comm/comments/list?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&object_id=%@&os_versions=9.1&page=0&pagesize=10&track_device_info=iPhone7%2C2&track_deviceid=E3778065-3D22-4BF9-8DD0-40FE7E543D83&type_id=2&v=7"

#define kListURL @"http://open3.bantangapp.com/product/relation?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&object_id=%@&os_versions=9.1&screensize=750"

@interface SearchGoodsDetailViewController ()<UICollectionViewDataSource>

@property (nonatomic,strong) UIScrollView *backView;
@property (nonatomic,strong) SearchGoodsHeaderView *headerView;
@property (nonatomic,strong) UICollectionView *collectView;
@property (nonatomic,strong) UICollectionView *topicView;


@property (nonatomic,strong) HomeProject *data;
@property (nonatomic,strong) NSMutableArray *topicArr;
@property (nonatomic,strong) NSMutableArray *productArr;
@end

@implementation SearchGoodsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.backView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.headerView = [[SearchGoodsHeaderView alloc]init];
    [self.backView addSubview:self.headerView];
    
    [self setNetData];
    [self setListData];
    
    
}

- (void)setNetData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    
    [AFNetworkTool JSONDataWithUrl:[[NSString stringWithFormat:kURL,self.ID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] success:^(id json)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *rootDic = json;
        NSDictionary *data = rootDic[@"data"];
        NSDictionary *product = data[@"product"];
        self.data = [[HomeProject alloc]init];
        [self.data setValuesForKeysWithDictionary:product];
        
        [self initHeaderView];
        [self initCollectionView];
        [self initTopicView];

    } fail:^{
        
    }];
}

- (void)setListData
{
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kListURL,self.ID] success:^(id json)
    {
        NSDictionary *dic = json;
        NSDictionary *data = dic[@"data"];
        
        self.topicArr = [NSMutableArray array];
        self.productArr = [NSMutableArray array];
        
        // topic
        NSArray *topic = data[@"topic"];
        
        for (NSDictionary *dic in topic)
        {
            SearchData *data = [[SearchData alloc]init];
            [data setValuesForKeysWithDictionary:dic];
            [self.topicArr addObject:data];
        }

        [self.topicView reloadData];
        
        NSArray *product = data[@"product"];

        // 产品
        for (NSDictionary *obj in product)
        {
            SearchData *data = [[SearchData alloc]init];
            [data setValuesForKeysWithDictionary:obj];
            [self.productArr addObject:data];
        }
        [self.collectView reloadData];
        
    
        
    } fail:^{
        
    }];
}

- (void)initHeaderView
{


    self.headerView.data = [[HomeProject alloc]init];
    self.headerView.data = self.data;
    self.headerView.backgroundColor = [UIColor whiteColor];
    CGFloat height = [self.headerView initSubviewsReturnHeight];
    self.headerView.frame = CGRectMake(0, 0, self.view.width, height);
    
}

- (void)initCollectionView
{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.width / 2 - 15, self.view.height / 3.5);
    
    self.collectView = [[UICollectionView alloc]initWithFrame:(CGRectMake(10, self.headerView.y + self.headerView.height + 20, self.view.width - 20, self.view.height)) collectionViewLayout:layout];
    self.collectView.scrollEnabled = NO;
    
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:self.collectView];
    self.collectView.dataSource = self;
    self.collectView.showsVerticalScrollIndicator = NO;
    
    [self.collectView registerClass:[SearchKeyDetailCollectionCell class] forCellWithReuseIdentifier:@"cell"];

}


- (void)initTopicView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.width / 2.5 - 15, self.view.height / 5);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.topicView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, self.view.width - 20, self.view.height)) collectionViewLayout:layout];
    
    self.topicView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:self.topicView];
    self.topicView.dataSource = self;
    self.topicView.showsHorizontalScrollIndicator = NO;
    
    [self.topicView registerClass:[SearchGoodsTopicCell class] forCellWithReuseIdentifier:@"topic"];}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView == self.collectView)
    {
        
        self.collectView.frame = CGRectMake(10, self.topicView.y + self.topicView.height + 20, self.view.width - 20, self.view.height / 3.5 * self.productArr.count / 2.0);
        
        return self.productArr.count;
    }
    else
        
    {
        self.topicView.frame = CGRectMake(0, self.headerView.y + self.headerView.height + 20, self.view.width,self.view.height / 5);
        
        self.backView.contentSize = CGSizeMake(0, self.headerView.y + self.headerView.height + self.view.height / 3.5 * self.productArr.count / 2 + self.view.height / 5 + 45);

        
        return self.topicArr.count;
    }

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectView) {
        
        SearchKeyDetailCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        SearchData *data = self.productArr[indexPath.item];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:data.pic]];
        cell.price.text = [NSString stringWithFormat:@"￥%@",data.price];
        cell.title.text = data.title;
        
        return cell;
    }else
    {
        SearchGoodsTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topic" forIndexPath:indexPath];
        SearchData *data = self.topicArr[indexPath.item];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:data.pic]];
        cell.title.text = data.title;
        
        return cell;
    }
}
@end
