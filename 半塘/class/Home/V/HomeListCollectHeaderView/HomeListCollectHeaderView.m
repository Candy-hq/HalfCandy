//
//  HomeListCollectHeaderView.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListCollectHeaderView.h"
#import "UIColor+AddColor.h"
#import "HomeListCollectHeaderRankView.h"

@implementation HomeListCollectHeaderView

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
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.width, self.height *0.4))];
    [self addSubview:self.pic];
    
    self.authorIcon = [[UIImageView alloc]initWithFrame:(CGRectMake(10, self.pic.height + 20, 40, 40))];
    self.authorIcon.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    [self addSubview:self.authorIcon];
    
    self.usernameLB = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    self.usernameLB.frame = CGRectMake(self.authorIcon.x + self.authorIcon.width + 10, self.authorIcon.y, self.width - (self.authorIcon.x + self.authorIcon.width + 10),20);
    self.usernameLB.font =[UIFont systemFontOfSize:15];
    [self addSubview:self.usernameLB];
    
    self.dataLB = [[UILabel alloc]initWithTitle:nil textColor:[UIColor grayColor]];
    self.dataLB.font = [UIFont systemFontOfSize:14];
    self.dataLB.x = self.usernameLB.x;
    self.dataLB.y = self.usernameLB.y + self.usernameLB.height;
    self.dataLB.size = self.usernameLB.size;
    [self addSubview:self.dataLB];
    
    self.desLB = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
//    self.desLB.backgroundColor = [UIColor redColor];
    self.desLB.numberOfLines = 0;
    self.desLB.frame = CGRectMake(self.authorIcon.x + 5, self.authorIcon.y + self.authorIcon.height + 5, self.width - (self.authorIcon.x * 2) - 5, self.height - 100 - (self.authorIcon.y + self.authorIcon.height - 20));
    self.desLB.font = [UIFont systemFontOfSize:15];
//    self.desLB.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.desLB];
    
    UIView *line = [[UIView alloc]initWithFrame:(CGRectMake(self.desLB.x, self.desLB.y + self.desLB.height + 10, self.width - 2 *self.desLB.x, 1))];
    line.backgroundColor = [UIColor huiseColor];
    [self addSubview:line];
    
    
    HomeListCollectHeaderRankView *rankView = [[HomeListCollectHeaderRankView alloc]initWithFrame:(CGRectMake(line.x, line.y + line.height + 10, line.width, 40))];
    self.rankView = rankView;
    [self addSubview:self.rankView];
//    rankView.backgroundColor = [UIColor yellowColor];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:(CGRectMake(rankView.x, rankView.height + rankView.y + 10, line.width, line.height))];
    bottomLine.backgroundColor = [UIColor huiseColor];
    [self addSubview:bottomLine];
    
}

@end
