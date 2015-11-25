//
//  DiscoverViewController.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "DiscoverViewController.h"
#define kURL @"http://open3.bantangapp.com/community/post/editorRec?app_installtime=1448283073.232938&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=f1c2d2aead94889f43f2a896013ac46a1e122ad154afe67fdd7473cce22d813d&last_time=1448281769&os_versions=9.1&page=0&pagesize=10&screensize=1242&track_device_info=iPhone7%2C1&track_deviceid=8D62E513-F586-4517-8FE9-63192FBCEAEC&v=7"
#define kListURL @"http://open3.bantangapp.com/community/subject/listPost?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=0&pagesize=10&screensize=750&subject_id=%@"



#import "AFNetworkTool.h"
#import "UIImageView+WebCache.h"
#import "Head.h"
#import "HeadView.h"
#import "UIButton+WebCache.h"
#import "ReportViewController.h"
#import "EveryProjectViewController.h"
#import "HomeListDesData.h"
#import "HomeListTableViewCell.h"
#import "MJRefresh.h"
#import "HomeListCollectionViewController.h"
#import "GoodsDetailViewController.h"
#import "Product.h"
#import "MBProgressHUD.h"

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *headArr;
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)HeadView *headView;
@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,assign) NSInteger page;
@property(nonatomic,strong)NSMutableArray *productArr;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    self.tableV = [[ UITableView alloc]initWithFrame:(CGRectMake(0, 0, width, height)) style:(UITableViewStylePlain)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.tableFooterView = [UIView new];
    [self.view addSubview:self.tableV];
    
    self.headView = [[HeadView alloc]initWithFrame:(CGRectMake(0, 0, width, width*3/5))];
    self.tableV.tableHeaderView = self.headView;
    
    [self.headView.btn1 addTarget:self action:@selector(intoShop) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headView.btn2 addTarget:self action:@selector(intoReport) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headView.btn3 addTarget:self action:@selector(intoEvery) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headView.btn4 addTarget:self action:@selector(intoNewPerson) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self setNetData];
    [self setNetData2];//解析listcell
    self.page = 0;
    self.tableV.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self setNetData2];
        [self.tableV.footer endRefreshing];
    }];
}
-(void)setNetData2
{
    [AFNetworkTool postJSONWithUrl:kURL parameters:nil success:^(id responseObject) {
        if (self.page == 0) {
            self.listArr = [NSMutableArray array];
        }
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dic = [rootDic objectForKey:@"data"];
        NSArray *arr = [dic objectForKey:@"list"];
        for (NSDictionary *dic in arr) {
            HomeListDesData *data = [[HomeListDesData alloc]init];
            [data setValuesForKeysWithDictionary:dic];
            [self.listArr addObject:data];
        }
        NSLog(@"%ld",self.listArr.count);
        self.page += 1;
        [self.tableV reloadData];
    } fail:^{
        NSLog(@"失败");
    }];
}
- (void)setNetData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFNetworkTool postJSONWithUrl:kURL parameters:nil success:^(id responseObject)
    {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.headArr = [NSMutableArray array];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *dic1 = [dic objectForKey:@"data"];
        NSArray *arr = [dic1 objectForKey:@"element"];
        for (NSDictionary *dic in arr) {
            Head *head = [[Head alloc]init];
            [head setValuesForKeysWithDictionary:dic];
            [self.headArr addObject:head];
        }
        [self.headView.btn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.headArr[0]pic1]]] forState:(UIControlStateNormal) placeholderImage:nil];
        [self.headView.btn2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.headArr[1]pic1]]] forState:(UIControlStateNormal) placeholderImage:nil];
        [self.headView.btn3 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.headArr[2]pic1]]] forState:(UIControlStateNormal) placeholderImage:nil];
        [self.headView.btn4 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.headArr[3]pic1]]] forState:(UIControlStateNormal) placeholderImage:nil];

        [self.tableV reloadData];
        
    } fail:^{
        NSLog(@"失败");
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    HomeListDesData *data = self.listArr[indexPath.row];
    CGRect rect = [data.content boundingRectWithSize:(CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, NSIntegerMax)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return 445 + rect.size.height + 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[HomeListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    //设置单元格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomeListDesData *data = self.listArr[indexPath.row];
    cell.data = data;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodVC = [[GoodsDetailViewController alloc]init];
    HomeListDesData *data = self.listArr[indexPath.row];
    goodVC.data = data;
    
    [self.navigationController pushViewController:goodVC animated:YES];
    
}
#pragma mark-headView button点击方法
-(void)intoReport
{
    ReportViewController *reportVC = [[ ReportViewController alloc]init];
    reportVC.webUrl = [self.headArr[1]extend];
    reportVC.title = [self.headArr[1]title];
    [self.navigationController pushViewController:reportVC animated:YES];
}
-(void)intoEvery
{
    EveryProjectViewController *everyVC = [[EveryProjectViewController alloc]init];
    everyVC.webUrl = [self.headArr[2]extend];
    everyVC.title = [self.headArr[2]title];
    [self.navigationController pushViewController:everyVC animated:YES];
}
-(void)intoShop
{
    HomeListCollectionViewController *listVC = [[HomeListCollectionViewController alloc]init];
    listVC.ID = [self.headArr[0]extend];
    [self.navigationController pushViewController:listVC animated:YES];
}
-(void)intoNewPerson
{
    HomeListCollectionViewController *listVC = [[HomeListCollectionViewController alloc]init];
    listVC.ID = [self.headArr[3]extend];
    [self.navigationController pushViewController:listVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
