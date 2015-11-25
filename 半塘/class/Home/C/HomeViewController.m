//
//  HomeViewController.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#define kURL @"http://open3.bantangapp.com/recommend/index?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=%ld&pagesize=20&screensize=750"

#import "HomeViewController.h"
#import "HomeListCollectionViewController.h"
#import "MBProgressHUD.h"
#import "HomePhoneViewCell.h"
#import "HomeTopic.h"
#import "AFNetworkTool.h"
#import "UIImageView+WebCache.h"
#import "HomeHeaderView.h"
#import "HomeBanner.h"
#import "HomeLIst.h"
#import "RefreshAutoFooter.h"
#import "HomeProjectdetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeHeaderView *homeHeaderV;
@property (nonatomic,strong) NSMutableArray *homePhoto;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,assign) CGFloat currentContentOfY;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;

    //
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 0;
    
    //
    self.tableView = [[UITableView alloc]initWithFrame:(self.view.frame) style:(UITableViewStylePlain)];
    
    self.homeHeaderV = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.45)];
    self.tableView.tableHeaderView = _homeHeaderV;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollsToTop = YES;
    [self.view addSubview:self.tableView];
    
//    MBProgressHUD
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;

    [self setNetData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    

    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    
        [self setNetData];
        [self.tableView.footer endRefreshing];
    }];
    
    //List 页面跳转
    __weak typeof(self) weakSelf = self;
    self.homeHeaderV.listBlock = ^(HomeLIst *list){
        HomeListCollectionViewController *listVC = [[HomeListCollectionViewController alloc]init];
        listVC.ID = list.ID;
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    };
}



- (void)setNetData
{
    

    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kURL,self.page] success:^(id json)
    {
        NSDictionary *rootDic = json;
        NSDictionary *dic = rootDic[@"data"];
        
        //
        NSArray *banner = dic[@"banner"];
        if (self.page == 0) {
            
            self.homeHeaderV.modelArr = [NSMutableArray array];
            for (NSDictionary *obj in banner) {
                HomeBanner *banner = [[HomeBanner alloc]init];
                [banner setValuesForKeysWithDictionary:obj];
                [self.homeHeaderV.modelArr addObject:banner];
            }
            
            //
            self.homeHeaderV.listArr = [NSMutableArray array];
            NSArray *entry_list = dic[@"entry_list"];
            for (NSDictionary *obj in entry_list) {
                HomeLIst *list = [[HomeLIst alloc]init];
                [list setValuesForKeysWithDictionary:obj];
                [self.homeHeaderV.listArr addObject:list];
            }
            
            //
            
            self.homePhoto = [NSMutableArray array];
        }
        NSArray *arr = dic[@"topic"];
        for (NSDictionary *obj in arr) {
            HomeTopic *pic = [[HomeTopic alloc]init];
            [pic setValuesForKeysWithDictionary:obj];
            [self.homePhoto addObject:pic];
        }
        self.page += 1;
            [self.tableView reloadData];
        
    } fail:^{
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homePhoto.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"phonto";

    HomePhoneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil)
    {
        cell = [[HomePhoneViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifer];
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    
    [cell.layer addAnimation:animation forKey:@"cude"];

    HomeTopic *pic = self.homePhoto[indexPath.row];
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:pic.pic]];
    cell.title.text = pic.title;
    cell.count.text = pic.likes;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProjectdetailViewController *detailVC = [[HomeProjectdetailViewController alloc]init];
    HomeTopic *data = self.homePhoto[indexPath.row];
    detailVC.ID = data.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (void)click
{
//    [self.navigationController pushViewController:[[aaaViewController alloc]init] animated:YES];
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.currentContentOfY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        
        if (scrollView.contentOffset.y > self.currentContentOfY)
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                self.navigationController.navigationBar.y = - 25;
                
            }];
            self.navigationItem.title = nil;
        }else
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                self.navigationController.navigationBar.y = 20;
            }];
            self.navigationItem.title = @"首页";
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.y = 20;
    _tableView.delegate = nil;
    _tableView.dataSource = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
