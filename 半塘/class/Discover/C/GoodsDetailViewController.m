//
//  GoodsDetailViewController.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"
#import "IntoTaoBaoViewController.h"
#import "BottomView.h"
#import "AFNetworkTool.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"
#import "Product.h"
#import "HomeListDesData.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface GoodsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIImageView *author_icon;
@property (nonatomic,strong) UILabel *author_name;
@property (nonatomic,strong) UILabel *datastr;
@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIImageView *recommend;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) Product *product;


@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 10, kWidth, kHeight - 10))];
    [self.view addSubview:self.scrollView];
    
    self.author_icon = [[UIImageView alloc]initWithFrame:(CGRectMake(10, 0, 40, 40))];
    self.author_icon.layer.cornerRadius = 20;
    self.author_icon.clipsToBounds = YES;
    [self.scrollView addSubview:self.author_icon];
    self.author_icon.backgroundColor = [UIColor redColor];
    
    // 关注
    UIButton *focus = [[UIButton alloc]init];
    focus.frame = CGRectMake(kScreenWith - 60 - 10 , self.author_icon.y + 10, 60, 20);
    focus.layer.cornerRadius = 8;
    focus.layer.borderWidth = 1;
    focus.layer.borderColor = [UIColor carrotColor].CGColor;
    [focus setTitle:@"关注" forState:(UIControlStateNormal)];
    [focus setTitleColor:[UIColor carrotColor] forState:(UIControlStateNormal)];
    [self.scrollView addSubview:focus];
    
    // recommend
    
    self.recommend = [[UIImageView alloc]initWithFrame:(CGRectMake(focus.x - 50, focus.y - 5 , 30, 30))];
    self.recommend.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:132 / 255.0 blue:134 / 2550. alpha:1.0];
    self.recommend.layer.cornerRadius = 15;
    self.recommend.image = [UIImage imageNamed:@"attach_28"];
    [self.scrollView addSubview:self.recommend];
    
    //
    self.author_name = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    self.author_name.frame = CGRectMake(self.author_icon.x + self.author_icon.width + 10, self.author_icon.y, kScreenWith - 2 * (self.author_icon.x + self.author_icon.width + 10), 20);
    self.author_name.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:self.author_name];
    
    //
    self.datastr = [[UILabel alloc]initWithTitle:nil textColor:[UIColor grayColor]];
    [self.scrollView addSubview:self.datastr];
    self.datastr.frame = CGRectMake(self.author_name.x, self.author_name.y + self.author_name.height, self.author_name.width, self.author_name.height);
    self.datastr.font = [UIFont systemFontOfSize:14];
    
    //
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(5, self.author_icon.y + self.author_icon.height + 20, kScreenWith-10, kScreenWith))];
    [self.scrollView addSubview:self.pic];
    
    [self.author_icon sd_setImageWithURL:[NSURL URLWithString:self.data.avatar]];
    self.author_name.text = self.data.username;
    self.datastr.text = self.data.datestr;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:self.data.picURL]];
    

    self.content = [[UILabel alloc]initWithFrame:(CGRectMake(self.author_icon.x, self.pic.y + self.pic.height + 10, kWidth-self.author_icon.x, 30))];
    [self.scrollView addSubview:self.content];
    self.content.numberOfLines = 0;
    self.content.text = self.data.content;
    [self.content sizeToFit];
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.textColor = [UIColor shenhuiseColor];
    
    if ([self.data.is_recommend isEqualToString:@"1"])
    {
        self.recommend.hidden = NO;
    }else
    {
        self.recommend.hidden = YES;
    }
    self.bottomView = [[BottomView alloc]initWithFrame:(CGRectMake(10, self.content.frame.origin.y+self.content.frame.size.height+10, kWidth- 20, kWidth/3))];
    self.bottomView.layer.cornerRadius = 10;
    [self.scrollView addSubview:self.bottomView];
    
    
    UIButton *but = [UIButton buttonWithType:(UIButtonTypeSystem)];
    but.frame = self.bottomView.frame;
    [but setTitle:@"购买" forState:(UIControlStateNormal)];
    [but setTintColor:[UIColor hongse2]];
    but.titleLabel.layer.cornerRadius = 5;

    but.titleLabel.font = [UIFont systemFontOfSize:20];
    but.titleEdgeInsets = UIEdgeInsetsMake(50, kWidth - 120, 80, 20);
    but.titleLabel.size = CGSizeMake(120, 30);

    [self.scrollView addSubview:but];
    [but addTarget:self action:@selector(intoAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.btn = but;
    
    self.scrollView.contentSize = CGSizeMake(0 , but.frame.origin.y + but.frame.size.height + 10);
    
    [self initWithData];
}

- (void)initWithData
{
    [AFNetworkTool postJSONWithUrl:[[NSString stringWithFormat:@"http://open3.bantangapp.com/community/post/info?app_installtime=1448283073.232938&app_versions=4.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=f1c2d2aead94889f43f2a896013ac46a1e122ad154afe67fdd7473cce22d813d&id=%@&oauth_token=3e0a7f7612d86a82f4a2ac9fa2857c8a&os_versions=9.1&track_deviceid=8D62E513-F586-4517-8FE9-63192FBCEAEC&track_user_id=1600161&v=7",self.data.ID] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(id responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *dic = [rootDic objectForKey:@"data"];
        NSDictionary *dic1 = [dic objectForKey:@"post"];
        NSArray *arr = [dic1 objectForKey:@"product"];
        
        if (arr.count == 0) {
            
            self.bottomView.title.text = @" 暂无数据 ";
            self.btn.userInteractionEnabled = NO;
            return;
        }
        
        NSDictionary *dic2 = arr[0];
        
        self.product = [[Product alloc]init];
        [self.product setValuesForKeysWithDictionary:dic2];
        NSLog(@"self.product.item_id=%@",self.product.item_id);
        [self.bottomView.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.product.pic]] placeholderImage:nil];
        self.bottomView.title.text = self.product.title;
        self.bottomView.price.text = self.product.price;
        
    } fail:^{
        NSLog(@"失败");
    }];
    

}
-(void)intoAction
{
    IntoTaoBaoViewController *taobaoVC = [[IntoTaoBaoViewController alloc]init];
    taobaoVC.ID = self.product.item_id;
    [self.navigationController pushViewController:taobaoVC animated:YES];

}


@end
