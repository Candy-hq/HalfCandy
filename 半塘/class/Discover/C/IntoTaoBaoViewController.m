//
//  IntoTaoBaoViewController.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//


#define kListURL @"http://h5.m.taobao.com/cm/snap/index.html?u_channel=1-23126600&umpChannel=1-23126600&exParams=%7B%22umpChannel%22:%221-23126600%22,%22u_channel%22:%221-23126600%22,%22referer%22:%22showTaoKeItemDetail%22%7D&ttid=2014_0_23126600@baichuan_ios_1.8.3&id=%@"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "IntoTaoBaoViewController.h"

@interface IntoTaoBaoViewController ()<UIWebViewDelegate>

@end

@implementation IntoTaoBaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:(CGRectMake(0, 0, kWidth, kHeight))];
    [self.view addSubview:webView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://h5.m.taobao.com/cm/snap/index.html?id=%@",self.ID]]];
    webView.delegate = self;
    [webView loadRequest:request];
    [webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}


@end
