//
//  ReportViewController.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "ReportViewController.h"

@interface ReportViewController ()<UIWebViewDelegate>

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.title;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:(CGRectMake(0, 0, kWidth, kHeight))];
    [self.view addSubview:webView];
    
    NSString *str = [NSString stringWithFormat:@"%@",self.webUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:20];
    webView.delegate = self;
    [webView loadRequest:request];
    [webView reload];
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
