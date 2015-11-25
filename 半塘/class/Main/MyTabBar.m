//
//  MyTabBar.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "MyTabBar.h"
@interface MyTabBar ()

@property (nonatomic,strong) UIButton *plusBtn;

@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.plusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:(UIControlStateNormal)];
        [self.plusBtn setImage:[UIImage imageNamed:@"tabbar_add"] forState:(UIControlStateNormal)];
        [self addSubview:self.plusBtn];
        [self.plusBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    self.plusBtn.center = CGPointMake(self.width / 2 + 10 ,self.height / 2);

    NSArray *subViews = [self subviews];
    CGFloat btnWidth = self.width / 5;
    CGFloat index = 0;
    for (UIView *child in subViews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            child.x = btnWidth * index;
            if (index == 1) {
                self.plusBtn.width = btnWidth;
                self.plusBtn.height = child.height;
                index ++;
            }
            index ++;
            
        }
        
    }
    
}


- (void)click:(UIButton *)button
{
    self.clickBlock();
    
}




@end
