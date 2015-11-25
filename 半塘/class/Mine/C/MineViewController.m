//
//  MineViewController.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "MineViewController.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "UMViewController.h"
#import "UMSocialControllerServiceComment.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *topView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *iconPic;
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
    [self initTopView];
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",cache);
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:self.tableView];
}

/* topView */
- (void)initTopView
{
    self.topView = [[UIImageView alloc]initWithFrame:(CGRectMake(0, -200, self.view.width, 200))];
    self.topView.image = [UIImage imageNamed:@"Tech_320.jpg"];
    self.topView.clipsToBounds = YES;
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    self.topView.autoresizesSubviews = YES;
    
    [self.tableView addSubview:self.topView];
    
    self.iconPic = [[UIImageView alloc]initWithFrame:(CGRectMake(self.topView.width / 2 - 40, -150, 80, 80))];
    self.iconPic.image = [UIImage imageNamed:@"dropdown_anim__0003"];
    self.iconPic.layer.cornerRadius = 40;
    self.iconPic.layer.borderWidth = 1;
    self.iconPic.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconPic.clipsToBounds = YES;
    [self.tableView addSubview:self.iconPic];
}

#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    

    
    cell.separatorInset = UIEdgeInsetsZero;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"分享应用";
            cell.imageView.image = [UIImage imageNamed:@"dropdown_anim__00040"];
            break;
            
        case 1:
            cell.textLabel.text = @"清理图片缓存";
            cell.imageView.image = [UIImage imageNamed:@"dropdown_anim__00013"];
            CGFloat size = [self cacheSize];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",size];
            break;
            
        case 2:
            cell.textLabel.text = @"皮肤设置";
            cell.imageView.image = [UIImage imageNamed:@"dropdown_anim__00053"];
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    
    if (indexPath.row == 0) {
        
    }

    
    if (indexPath.row == 1)
    {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认清除图片缓存" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
        {
            
            [self cleanCache];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alertVC addAction:action1];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    if (indexPath.row == 2)
    {
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    CGRect frame = self.topView.frame;
    frame.origin.y = y;
    frame.size.height = - y;
    self.topView.frame = frame;
    
}

#pragma mark - 缓存大小

- (float)cacheSize
{
    
    float byteSize = [SDImageCache sharedImageCache].getSize;
    float size = byteSize / 1000.0 / 1000.0;
    return size;
    
}

- (void)cleanCache
{

    [[SDImageCache sharedImageCache] clearDisk];
}

@end
