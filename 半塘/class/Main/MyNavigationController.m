//
//  MyNavigationController.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface MyNavigationController ()


@end

@implementation MyNavigationController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(backAction:) image:@"bs_camera_back" highImage:@"bs_camera_back"];
    }
    
    [super pushViewController:viewController animated:animated];
    self.navigationBar.barTintColor = honse;
    

    
}

- (void)backAction:(UIBarButtonItem *)barButton
{
    [self popViewControllerAnimated:YES];
}
@end
