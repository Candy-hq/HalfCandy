//
//  HotSearchView.m
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HotSearchView.h"
#import "UIColor+AddColor.h"

@implementation HotSearchView


-(NSArray *)hotArr
{
    if (!_hotArr) {
        _hotArr = [NSArray array];
    }
    return _hotArr;
}

- (void)initSubViews
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    UILabel *hotSearch = [[UILabel alloc]initWithTitle:@"热门搜索" textColor:[UIColor grayColor]];
    hotSearch.frame = CGRectMake(10, 10, self.width - 20, 20);
    hotSearch.font = [UIFont systemFontOfSize:15];
    [self addSubview:hotSearch];
    
    CGFloat Y = hotSearch.y + hotSearch.height + 30;
    CGFloat W = 10;
    for (int i = 0; i < self.hotArr.count; i++)
    {
        NSString *str = self.hotArr[i];

        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.userInteractionEnabled = YES;
        [btn setTitle:str forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor shenhuiseColor] forState:(UIControlStateNormal)];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor huiseColor].CGColor;
        
        
        CGRect rect = [str boundingRectWithSize:(CGSizeMake(NSIntegerMax, 30)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
        btn.x = W;
        btn.width = rect.size.width + 30;
        btn.layer.cornerRadius = 10;
        btn.height = 30;
        
        
        if (btn.width + btn.x + 10 > 270)
        {
            btn.y = Y + btn.height + 20;
            Y = btn.y;
            W = 10;
        }else
        {
            btn.y = Y;
            W = btn.x + btn.width + 10;

        }
        
        
        [self addSubview:btn];        
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
}

- (void)clickAction:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
    NSString *str = btn.titleLabel.text;
    self.strBlcok(str);
}
@end
