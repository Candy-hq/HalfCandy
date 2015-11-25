//
//  HomeListSelectView.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListSelectView.h"
#import "UIColor+AddColor.h"

@interface HomeListSelectView ()


@end

@implementation HomeListSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label_1 = [[UILabel alloc]initWithTitle:@"最新" textColor:[UIColor grayColor]];
        self.label_1.frame = CGRectMake(frame.size.width / 4 - 40, 5, 80, 20);
        self.label_1.textAlignment = NSTextAlignmentCenter;
        self.label_1.userInteractionEnabled = YES;
        self.label_1.font = [UIFont systemFontOfSize:15];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click1)];
        [self.label_1 addGestureRecognizer:tap1];
        [self addSubview:_label_1];
        
        UIView *line = [[UIView alloc]initWithFrame:(CGRectMake(frame.size.width / 2 - 1, 0, 1, frame.size.height * 0.65))];
        line.backgroundColor = [UIColor huiseColor];
        [self addSubview:line];
        
        self.label_2 = [[UILabel alloc]initWithTitle:@"精选" textColor:[UIColor grayColor]];
        self.label_2.frame = CGRectMake(frame.size.width / 4 * 3 - 40, 5, 80, 20);
        self.label_2.textAlignment = NSTextAlignmentCenter;
        self.label_2.font = [UIFont systemFontOfSize:15];
        self.label_2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click2)];
        [self.label_2 addGestureRecognizer:tap2];
        [self addSubview:_label_2];
        
        self.line = [[UIView alloc]init];
        self.line.x = self.label_1.x;
        self.line.y = frame.size.height - 2;
        self.line.width = self.label_1.width;
        self.line.height = 2;
        self.line.backgroundColor = [UIColor redColor];
        [self addSubview:self.line];
        
    }
    return self;
}

- (void)click1
{
    self.click_1();
    [UIView animateWithDuration:0.3 animations:^{
        self.line.x = self.label_1.x;
    }];
    
}
- (void)click2
{
    self.click_2();
    [UIView animateWithDuration:0.3 animations:^{
        self.line.x = self.label_2.x;
    }];
}

@end
