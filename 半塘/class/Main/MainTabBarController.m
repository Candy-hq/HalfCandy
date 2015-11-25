//
//  MainTabBarController.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "SearchViewController.h"
#import "MineViewController.h"
#import "MyTabBar.h"
#import "MyNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    DiscoverViewController *disVC = [[DiscoverViewController alloc]init];
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    
    [self addChildViewController:homeVC title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    [self addChildViewController:disVC title:@"发现" image:@"iconfont-zhinanzhen-3" selectImage:@"iconfont-zhinanzhen"];

    [self addChildViewController:searchVC title:@"搜索" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    [self addChildViewController:mineVC title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    


    MyTabBar *myTabBar = [[MyTabBar alloc]init];
    [self setValue:myTabBar forKeyPath:@"tabBar"];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = honse;

    __weak typeof(self) weakSelf = self;
    
    myTabBar.clickBlock = ^()
    {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"我们正在努力完善此页面~~请等待哦" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alertVC afterDelay:2];
    };
    
}

- (void)dismiss:(UIAlertController *)alertVC
{
    [alertVC dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 添加TabBar子控制器
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childController.title = title;
    
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    MyNavigationController *naVC = [[MyNavigationController alloc]initWithRootViewController:childController];
    
    // 设置导航栏字体颜色  和 背景色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [self addChildViewController:naVC];
    

    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
