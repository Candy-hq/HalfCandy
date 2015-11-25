//
//  SearchListTableViewController.m
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchListTableViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkTool.h"
#import "HomeTopic.h"
#import "HomePhoneViewCell.h"
#import "MJRefresh.h"
#import "HomeProjectdetailViewController.h"
#import "MBProgressHUD.h"

#define kURL @"http://open3.bantangapp.com/topic/list?app_installtime=1447848545.687913&app_versions=4.3&category=%@&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=%@&pagesize=20&screensize=750"


@interface SearchListTableViewController ()

@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,assign) NSInteger page;

@end

@implementation SearchListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.listArr = [NSMutableArray array];
    self.page = 0;
    
    [self setNetData];
    
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       
        [self setNetData];
        [self.tableView.footer endRefreshingWithNoMoreData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setNetData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kURL,self.ID,[NSString stringWithFormat:@"%ld",self.page]] success:^(id json) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *rootDic = json;
        NSArray *data = rootDic[@"data"];
        for (NSDictionary *obj in data) {
            HomeTopic *pic = [[HomeTopic alloc]init];
            [pic setValuesForKeysWithDictionary:obj];
            [self.listArr addObject:pic];
            
        }
        self.page += 1;
        [self.tableView reloadData];
        
    } fail:^{

    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifer = @"listCell";
    HomePhoneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[HomePhoneViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifer];
    }
    HomeTopic *data = self.listArr[indexPath.row];
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:data.pic]];
    cell.title.text = data.title;
    cell.count.text = data.likes;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProjectdetailViewController *detailVC = [[HomeProjectdetailViewController alloc]init];
    HomeTopic *data = self.listArr[indexPath.row];
    detailVC.ID = data.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
