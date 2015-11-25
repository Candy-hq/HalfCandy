//
//  SearchViewController.m
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCollectionViewCell.h"
#import "AFNetworkTool.h"
#import "UIImageView+WebCache.h"
#import "Search.h"
#import "UIColor+AddColor.h"
#import "SearchListTableViewController.h"
#import "HotSearchView.h"
#import "SearchKeyDetailView.h"
#import "SearchData.h"
#import "HomeListSelectView.h"
#import "HomeProjectdetailViewController.h"
#import "MJRefresh.h"
#import "SearchGoodsDetailViewController.h"
#import "MBProgressHUD.h"

#define kURL @"http://open3.bantangapp.com/category/list?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&"

#define KSearchHot @"http://open3.bantangapp.com/base/search/hottags?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&track_device_info=iPhone7%2C2&track_deviceid=E3778065-3D22-4BF9-8DD0-40FE7E543D83&v=7"

#define KSearchURL @"http://open3.bantangapp.com/base/search/initData?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&keyword=%@&os_versions=9.1&page=%ld&pagesize=20&screensize=750"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray *searchList;
@property (nonatomic,strong) HotSearchView *hotView;
@property (nonatomic,strong) NSMutableArray *hotlistArr;
@property (nonatomic,strong) SearchKeyDetailView *resultView;

@property (nonatomic,assign) NSInteger page;

@end

@implementation SearchViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 2 - 10, (kScreenHeight - 10) / 8);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 0;
    
    self.view.backgroundColor = [UIColor huiseColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(5, 5, self.view.width - 10, self.view.height - 10);
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:(CGRectMake(0, 0, 300, 30))];
    self.searchBar.delegate = self;
    
    
    self.navigationItem.titleView = self.searchBar;
    
    [self setNetData];
    
    [self setHotData];
    
    
    // Register cell classes
    [self.collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}


- (void)setNetData
{
    [AFNetworkTool JSONDataWithUrl:kURL success:^(id json) {
        
        self.searchList = [NSMutableArray array];
        NSDictionary *rootDic = json;
        NSArray *data = rootDic[@"data"];
        for (NSDictionary *obj in data) {
            Search *list = [[Search alloc]init];
            [list setValuesForKeysWithDictionary:obj];
            [self.searchList addObject:list];
        }
        
        [self.collectionView reloadData];
    } fail:^{
        
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    
    [cell.layer addAnimation:animation forKey:@"cude"];
    

    Search *data = self.searchList[indexPath.item];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:data.icon]];
    cell.title.text = data.name;
    cell.subTitle.text = data.en_name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Search *data = self.searchList[indexPath.item];
    SearchListTableViewController *listVC = [[SearchListTableViewController alloc]init];
    listVC.ID = data.ID;
    listVC.title = data.name;
    [self.navigationController pushViewController:listVC animated:YES];
}


#pragma mark - searchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.hotView removeFromSuperview];
    searchBar.showsCancelButton = YES;
    self.collectionView.userInteractionEnabled = NO;
    
    for (id cancelBtn in [searchBar.subviews[0] subviews])
    {
        if ([cancelBtn isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cancelBtn;
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        }
    }
    
    self.hotView = [[HotSearchView alloc]initWithFrame:(CGRectMake(0, self.view.height, self.view.width, self.view.height))];
    self.hotView.hotArr = self.hotlistArr;
    
    [self.hotView initSubViews];
    [self.view addSubview:_hotView];
    
    self.hotView.strBlcok = ^(NSString *str){
        searchBar.text = str;
    };
    
    [UIView animateWithDuration:0.2 animations:^{
        self.hotView.y = 64;
    }];
    
    return YES;
}


/* 键盘取消按钮 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.page = 0;
    [searchBar endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
    self.collectionView.userInteractionEnabled = YES;
    self.searchBar.text = nil;
    if (searchBar.text != 0) {
        
        [self.hotView removeFromSuperview];
        [self.resultView removeFromSuperview];
//        [self.view bringSubviewToFront:self.collectionView];
    }

    
}


#pragma mark -- 键盘Search按钮 --- resuleView

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length != 0)
    {
        _resultView = [[SearchKeyDetailView alloc]initWithFrame:(CGRectMake(0, 64, self.view.width, self.view.height - 64))];
        [self.view addSubview:_resultView];

        // tableView
        __weak typeof(self) weakSelf = self;
        self.resultView.tableViewClick = ^(NSString *str)
        {
            HomeProjectdetailViewController *detailVC = [[HomeProjectdetailViewController alloc]init];
            detailVC.title = @"专题详情";
            detailVC.ID = str;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
            
        };
        
        //collectionView
        
        self.resultView.collectionClick = ^(NSString *str)
        {
            SearchGoodsDetailViewController *goodsVC = [[SearchGoodsDetailViewController alloc]init];
            goodsVC.title = @"物品详情";
            goodsVC.ID = str;
            [weakSelf.navigationController pushViewController:goodsVC animated:YES];
            
        };
        
        [searchBar resignFirstResponder];
        
        self.page = 0;
        [self setSearchKeyData];
        
        
        /* MJRefresh */

        self.resultView.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self setSearchKeyData];
            [self.resultView.tableView.footer endRefreshing];
            [self.resultView.collectView.footer endRefreshing];
        }];
        self.resultView.collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self setSearchKeyData];
            [self.resultView.tableView.footer endRefreshing];
            [self.resultView.collectView.footer endRefreshing];
        }];
    }
    
}

- (void)setSearchKeyData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    
    [AFNetworkTool JSONDataWithUrl:[[NSString stringWithFormat:KSearchURL,self.searchBar.text,self.page] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] success:^(id json)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         if (self.page == 0) {
             self.resultView.tableViewArr = [NSMutableArray array];
             self.resultView.collectArr = [NSMutableArray array];
         }
         
         NSDictionary *rootDic = json;
         NSDictionary *data = rootDic[@"data"];
         
         // colletctionView
         NSArray *product = data[@"product"];
         for (NSDictionary *obj in product)
         {
             SearchData *data = [[SearchData alloc]init];
             [data setValuesForKeysWithDictionary:obj];
             [self.resultView.collectArr addObject:data];
         }
         
         [self.resultView.collectView reloadData];
         
         // tableView
         NSArray *topic = data[@"topic"];
         for (NSDictionary *obj in topic) {
             SearchData *data = [[SearchData alloc]init];
             [data setValuesForKeysWithDictionary:obj];
             [self.resultView.tableViewArr addObject:data];
         }
         self.page += 1;
         [self.resultView.tableView reloadData];
         
     } fail:^{
         
     }];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.page = 0;
    if (searchText.length == 0) {
        return;
    }
    
    [self.resultView removeFromSuperview];
    
}

#pragma mark - hotViewData

- (void)setHotData
{
    self.hotlistArr = [NSMutableArray array];
    [AFNetworkTool JSONDataWithUrl:KSearchHot success:^(id json) {
        NSDictionary *rootDic = json;
        NSArray *data = rootDic[@"data"];
        for (NSString *str in data) {
            [self.hotlistArr addObject:str];
        }
        
    } fail:^{
        
    }];
}

@end
