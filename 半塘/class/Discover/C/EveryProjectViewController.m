//
//  EveryProjectViewController.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "EveryProjectViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface EveryProjectViewController ()<UIWebViewDelegate>

@end

@implementation EveryProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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


@end
