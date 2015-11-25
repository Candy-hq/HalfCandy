//
//  BottomView.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "BottomView.h"
#import "UIColor+AddColor.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface BottomView ()

@end
@implementation BottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor huiseColor];
        self.name = [[UILabel alloc]initWithFrame:(CGRectMake(10, 5, frame.size.width-10, 20))];
        self.name.text = @"相关链接";
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textColor = [UIColor grayColor];
        [self addSubview:self.name];
        
        self.imageV = [[UIImageView alloc]initWithFrame:(CGRectMake(self.name.frame.origin.x, self.name.frame.origin.y+self.name.frame.size.height+5, kWidth/4.68, kWidth/4.68-5))];
        [self addSubview:self.imageV];
//        self.imageV.backgroundColor = [UIColor redColor];
        
        self.title = [[UILabel alloc]initWithFrame:(CGRectMake(self.imageV.frame.origin.x+self.imageV.frame.size.width+5, self.imageV.frame.origin.y, frame.size.width-5-10-self.imageV.frame.size.width, 30))];
        [self addSubview:self.title];
//        self.title.backgroundColor = [UIColor redColor];
        self.title.textColor = [UIColor grayColor];
        
        self.price = [[UILabel alloc]initWithFrame:(CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y+self.title.frame.size.height+5, self.title.frame.size.width, 30))];
        [self addSubview:self.price];
//        self.price.backgroundColor = [UIColor redColor];
        self.price.textColor = [UIColor grayColor];
    }
    return self;
}

@end
