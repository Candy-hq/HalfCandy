//
//  HeadView.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.btn1.frame = CGRectMake(0, 0, width*3/5, width*3/5);
//        self.btn1.backgroundColor = [UIColor blueColor];
        [self addSubview:self.btn1];

        self.btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.btn2.frame = CGRectMake(self.btn1.frame.size.width+3, 0, width-self.btn1.frame.size.width-3, width-self.btn1.frame.size.width-3);
//        self.btn2.backgroundColor = [UIColor grayColor];
        [self addSubview:self.btn2];
        
        self.btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.btn3.frame = CGRectMake(self.btn2.frame.origin.x, self.btn2.frame.size.height+3, self.btn2.frame.size.width/2, self.btn1.frame.size.height-self.btn2.frame.size.height-3);
//        self.btn3.backgroundColor = [UIColor blueColor];
        [self addSubview:self.btn3];
        
        self.btn4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.btn4.frame = CGRectMake(self.btn3.frame.origin.x+self.btn3.frame.size.width+3, self.btn3.frame.origin.y, self.btn2.frame.size.width-self.btn3.frame.size.width-3, self.btn3.frame.size.height);
//        self.btn4.backgroundColor = [UIColor blueColor];
        [self addSubview:self.btn4];
       
        
    }
    return self;
}
@end
