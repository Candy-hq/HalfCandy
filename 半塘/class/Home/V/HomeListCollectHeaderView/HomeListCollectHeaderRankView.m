//
//  HomeListCollectHeaderRankView.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListCollectHeaderRankView.h"

@implementation HomeListCollectHeaderRankView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIImageView *numberView = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, 50, self.height - 20))];
    numberView.image = [UIImage imageNamed:@"subject_number_one"];
    [self addSubview:numberView];
    UILabel *rank = [[UILabel alloc]initWithTitle:@"排行榜" textColor:[UIColor grayColor]];
    rank.font = [UIFont systemFontOfSize:12];
    rank.textAlignment = NSTextAlignmentCenter;
    rank.frame = CGRectMake(numberView.x, numberView.y + numberView.height, numberView.width, 20);
    [self addSubview:rank];
    
    //
    self.icon_1 = [[UIImageView alloc]initWithFrame:(CGRectMake(numberView.x + numberView.width+ 10, numberView.y - 5, 40, 40))];
    self.icon_1.layer.cornerRadius = 20;
    self.icon_1.clipsToBounds = YES;
    self.icon_1.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.icon_1];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_1.x + self.icon_1.width + 10, self.icon_1.y + 5, 10, 40))];
    line.image = [UIImage imageNamed:@"subject_separator_line"];
    [self addSubview:line];
    
    self.icon_2 = [[UIImageView alloc]initWithFrame:(CGRectMake(line.x + line.width + 10, line.y, 30, 30))];
    self.icon_2.layer.cornerRadius = 15;
    self.icon_2.clipsToBounds = YES;
    self.icon_2.backgroundColor = [UIColor blackColor];
    [self addSubview:self.icon_2];
    
    self.icon_3 = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_2.x + self.icon_2.width + 10, self.icon_2.y, 30, 30))];
    self.icon_3.layer.cornerRadius = 15;
    self.icon_3.clipsToBounds = YES;
    self.icon_3.backgroundColor = [UIColor blackColor];
    [self addSubview:self.icon_3];
    
    self.icon_4 = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_3.x + self.icon_3.width + 10, self.icon_3.y, 30, 30))];
    self.icon_4.layer.cornerRadius = 15;
    self.icon_4.clipsToBounds = YES;
    self.icon_4.backgroundColor = [UIColor blackColor];
    [self addSubview:self.icon_4];
    
    self.icon_5 = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_4.x + self.icon_4.width + 10, self.icon_4.y, 30, 30))];
    self.icon_5.layer.cornerRadius = 15;
    self.icon_5.clipsToBounds = YES;
    self.icon_5.backgroundColor = [UIColor blackColor];
    [self addSubview:self.icon_5];
    
    self.icon_6 = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_5.x + self.icon_5.width + 10, self.icon_5.y, 30,30))];
    self.icon_6.layer.cornerRadius = 15;
    self.icon_6.clipsToBounds = YES;
    self.icon_6.backgroundColor = [UIColor blackColor];
    [self addSubview:self.icon_6];

    UIImageView *right = [[UIImageView alloc]initWithFrame:(CGRectMake(self.icon_6.x + self.icon_6.width + 10, self.icon_6.y + 5, 15, 20))];
    right.image = [UIImage imageNamed:@"subject_arrow_right"];
    [self addSubview:right];
                               
}
@end
