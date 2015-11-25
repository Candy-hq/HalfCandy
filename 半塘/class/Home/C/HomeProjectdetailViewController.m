//
//  HomeProjectdetailViewController.m
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#define kUrl @"http://open3.bantangapp.com/topic/info?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@"

#define kRecommend_URL @"http://open3.bantangapp.com/community/post/listByTags?app_installtime=1447848545.687913&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.1&page=0&pagesize=20&screensize=750&show_product=1&tag_ids=%@&track_device_info=iPhone7%2C2&track_deviceid=E3778065-3D22-4BF9-8DD0-40FE7E543D83&type_id=1&v=7"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#import "HomeProjectdetailViewController.h"
#import "HomeProjectHeaderView.h"
#import "HomeListSelectView.h"
#import "AFNetworkTool.h"
#import "UIImageView+WebCache.h"
#import "HomeProject.h"
#import "HomeProjectTableViewCell.h"
#import "MBProgressHUD.h"
#import "HomeListTableViewCell.h"
#import "HomeListDesData.h"

@interface HomeProjectdetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeProjectHeaderView *headerV;
@property (nonatomic,strong) NSMutableArray *listArr;

@property (nonatomic,assign) BOOL isFirst;

@end

@implementation HomeProjectdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isFirst = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"专题详情";
    [self initTableView];
    [self setNetData];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    

}

#pragma mark - Net


// 精选
- (void)setNetData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kUrl,self.ID] success:^(id json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dic = json;
        NSDictionary *data = dic[@"data"];
        
        // headerView
        CGRect rect = [data[@"desc"] boundingRectWithSize:(CGSizeMake(self.view.width - 40, NSIntegerMax)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        CGFloat height = self.view.width * 0.6 + rect.size.height + 20;
        
        self.headerV = [[HomeProjectHeaderView alloc]initWithFrame:(CGRectMake(0, 0, self.view.width, height))];
        self.tableView.tableHeaderView = _headerV;
        // 设置tableView headerView
        
        self.headerV.pic.frame = CGRectMake(0, 0, self.headerV.width, self.headerV.width * 0.6);
        
        self.headerV.mask.frame = CGRectMake(0,self.headerV.pic.height - 20, self.headerV.pic.width, 20);
        
        self.headerV.title.frame = CGRectMake(self.headerV.pic.x + 10, self.headerV.pic.height - 15, self.headerV.width - 20, 10);
        self.headerV.backgroundColor = [UIColor whiteColor];
        self.headerV.content.frame =  CGRectMake(20, self.headerV.pic.y + self.headerV.pic.height + 10, self.view.width - 40, rect.size.height);
        
        [self.headerV.pic sd_setImageWithURL:[NSURL URLWithString:data[@"pic"]]];
        self.headerV.content.text = data[@"desc"];
        self.headerV.title.text = data[@"title"];
    
        // cell
        
        NSArray *product = data[@"product"];
        self.listArr = [NSMutableArray array];
        {
            for (NSDictionary *dic in product) {
                HomeProject *data = [[HomeProject alloc]init];
                [data setValuesForKeysWithDictionary:dic];
                [self.listArr addObject:data];
            }
            [self.tableView reloadData];
        }
        
    } fail:^{
        NSLog(@"fail");
        
    }];
}

#pragma mark - 推荐

- (void)setData
{
    [AFNetworkTool JSONDataWithUrl:[NSString stringWithFormat:kUrl,self.ID] success:^(id json)
    {
        self.listArr = [NSMutableArray array];
        NSDictionary *rootDic = json;
        NSDictionary *data = rootDic[@"data"];
        NSArray *list = data[@"list"];
        for (NSDictionary *dic in list) {
            HomeListDesData *data = [[HomeListDesData alloc]init];
            [data setValuesForKeysWithDictionary:dic];
            [self.listArr addObject:data];
        }
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isFirst == YES) {
        
        static NSString *identifer = @"cell";
        HomeProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            cell = [[HomeProjectTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *imageArray = cell.contentView.subviews;
        
        for (UIView *view in imageArray) {
            
            if ([view isKindOfClass:[UIImageView class]]) {
                
                [view removeFromSuperview];
            }
        }
        
        HomeProject *data = self.listArr[indexPath.row];
        
        {  // 赋值
            
            cell.number.text = [NSString stringWithFormat:@"%ld",indexPath.row];
            cell.title.text = data.title;
            cell.desc.text = data.desc;
            
            cell.desc.frame = CGRectMake(cell.number.x, cell.number.y + cell.number.height + 10, kScreenWidth - 2 * cell.number.x, 20);
            
            cell.desc.numberOfLines = 0;
            [cell.desc sizeToFit];
            
            for (int i = 0; i < data.picArr.count; i++)
            {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:(CGRectMake(cell.desc.x, cell.desc.height + cell.desc.y + 10 + ((cell.desc.width + 3) * i), cell.desc.width, cell.desc.width))];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView sd_setImageWithURL:[NSURL URLWithString:data.picArr[i]]];
                [cell.contentView addSubview:imageView];
            }
        }
        
        return cell;
    }
    if (self.isFirst == NO) {
        HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[HomeListTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell2"];
        }
        HomeProject *data = self.listArr[indexPath.row];
        cell.data = data;
        return cell;
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeListSelectView *view = [[HomeListSelectView alloc]initWithFrame:(CGRectMake(0, 0, self.view.width, 30))];
    view.label_1.text = @"半糖精选";
    view.label_2.text = @"用户推荐";
    view.backgroundColor = [UIColor whiteColor];
    
    view.click_1 = ^{
        self.isFirst = YES;
        [self setNetData];
    };
    
    view.click_2 = ^{
        self.isFirst = NO;
        [self setData];
        [self.tableView reloadData];
    };

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (self.isFirst == YES) {
        
        HomeProject *data = self.listArr[indexPath.row];
        CGRect rect = [data.desc boundingRectWithSize:(CGSizeMake(kScreenWidth, NSIntegerMax)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        return 60 + rect.size.height + (kScreenWidth - 20 + 5) * data.picArr.count ;
    }
    return 100;
}
@end
