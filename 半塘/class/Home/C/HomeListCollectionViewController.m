//
//  HomeListCollectionViewController.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#define kURL @"http://open3.bantangapp.com/community/subject/info?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&screensize=750&subject_id=%@"

#define kListURL @"http://open3.bantangapp.com/community/subject/listPost?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=0&pagesize=10&screensize=750&subject_id=%@"

#define kListCellUrl @"http://open3.bantangapp.com/community/subject/listPost?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=%@&pagesize=10&screensize=750&subject_id=%@"


#import "HomeListCollectionViewController.h"
#import "AFNetworkTool.h"
#import "HomeListCollectHeaderView.h"
#import "HomeListHeader.h"
#import "UIImageView+WebCache.h"
#import "HomeListRank.h"
#import "HomeListCollectHeaderRankView.h"
#import "HomeListSelectView.h"
#import "UIColor+AddColor.h"
#import "HomeListTableViewCell.h"
#import "HomeListDesData.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface HomeListCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeListCollectHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *rankList;
@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,assign) NSInteger page;


@end

@implementation HomeListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本期话题";
    [self initTableView];
    [self setNetData];
    [self setCellData];
    self.page = 0;

    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    
        [self setCellData];
        [self.tableView.footer endRefreshing];
    }];
}


- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor huiseColor];
    //
    self.headerView = [[HomeListCollectHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.6)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.tableView];

}


- (void)setNetData
{
    
    // headerView
    
    
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kURL,self.ID] success:^(id json) {
        NSLog(@"%@",[NSString stringWithFormat:kURL,self.ID]);
        NSDictionary *rooDic = json;
        NSDictionary *data = rooDic[@"data"];
        NSDictionary *subject = data[@"subject"];
        HomeListHeader *listHeader = [[HomeListHeader alloc]init];
        [listHeader setValuesForKeysWithDictionary:subject];
        
        //
        [self.headerView.pic sd_setImageWithURL:[NSURL URLWithString:listHeader.pic2]];
        [self.headerView.authorIcon sd_setImageWithURL:[NSURL URLWithString:listHeader.author_avatar]];
        self.headerView.usernameLB.text = listHeader.author_username;
        self.headerView.dataLB.text = listHeader.datestr;
        
        self.headerView.desLB.text = listHeader.description1;
        
        //
        NSDictionary *dynamic = subject[@"dynamic"];
        NSArray *rank_list = dynamic[@"rank_list"];
        self.rankList = [NSMutableArray array];
        
        for (NSDictionary *dic in rank_list) {
            HomeListRank *rank = [[HomeListRank alloc]init];
            [rank setValuesForKeysWithDictionary:dic];
            [self.rankList addObject:rank];
        }
        [self rankFuzhi];

    } fail:^{
        
    }];
    
}

- (void)setCellData
{
    // cell
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kListCellUrl,page,self.ID] success:^(id json)
     {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (self.page == 0) {
            
            self.listArr = [NSMutableArray array];
        }
        
        NSDictionary *rootDic = json;
        NSDictionary *data = rootDic[@"data"];
        NSArray *list = data[@"list"];
        for (NSDictionary *obj in list) {
            HomeListDesData *data = [[HomeListDesData alloc]init];
            [data setValuesForKeysWithDictionary:obj];
            [self.listArr addObject:data];
        }
        self.page += 1;

        [self.tableView reloadData];
    } fail:^{
        
        NSLog(@"fail");
    }];
    
}

- (void)rankFuzhi
{

    HomeListRank *rank1 = self.rankList[0];
    [self.headerView.rankView.icon_1 sd_setImageWithURL:[NSURL URLWithString:rank1.avatar]];
    
    HomeListRank *rank2 = self.rankList[1];
    [self.headerView.rankView.icon_2 sd_setImageWithURL:[NSURL URLWithString:rank2.avatar]];
    
    HomeListRank *rank3 = self.rankList[2];
    [self.headerView.rankView.icon_3 sd_setImageWithURL:[NSURL URLWithString:rank3.avatar]];
    
    HomeListRank *rank4 = self.rankList[3];
    [self.headerView.rankView.icon_4 sd_setImageWithURL:[NSURL URLWithString:rank4.avatar]];
    
    HomeListRank *rank5 = self.rankList[4];
    [self.headerView.rankView.icon_5 sd_setImageWithURL:[NSURL URLWithString:rank5.avatar]];
    
    HomeListRank *rank6 = self.rankList[5];
    [self.headerView.rankView.icon_6 sd_setImageWithURL:[NSURL URLWithString:rank6.avatar]];
    
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeListSelectView *selectView = [[HomeListSelectView alloc]initWithFrame:(CGRectMake(0, 0, self.view.width, 30))];
    selectView.backgroundColor = [UIColor whiteColor];
    
    selectView.click_1 = ^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
        [self.tableView reloadData];

    };
    selectView.click_2 = ^{

        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    };
    return selectView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[HomeListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomeListDesData *data = self.listArr[indexPath.row];
    cell.data = data;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    HomeListDesData *data = self.listArr[indexPath.row];
    CGRect rect = [data.content boundingRectWithSize:(CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, NSIntegerMax)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return 445 + rect.size.height + 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
