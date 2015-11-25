//
//  SearchCollectionViewCell.m
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "UIColor+AddColor.h"

@implementation SearchCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.icon = [[UIImageView alloc]initWithFrame:(CGRectMake(20, 30, 40, 40))];
    self.icon.centerY = self.height / 2;
    [self.contentView addSubview:self.icon];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    [self.contentView addSubview:self.title];
    self.title.frame = CGRectMake(self.icon.x + self.icon.width + 10, self.icon.y, self.width - (self.icon.x + self.icon.width + 20), 20);
    self.title.font = [UIFont systemFontOfSize:16];
    
    self.subTitle = [[UILabel alloc]initWithTitle:nil textColor:[UIColor grayColor]];
    
    self.subTitle.frame = CGRectMake(self.title.x, self.title.y + self.title.height, self.title.width, self.title.height);
    self.subTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.subTitle];
    
    UIView *horizenLine = [[UIView alloc]init];
    horizenLine.backgroundColor = [UIColor huiseColor];
    [self.contentView addSubview:horizenLine];
    horizenLine.frame = CGRectMake(self.width - 1, self.icon.y, 1, self.height - 2 * self.icon.y);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor huiseColor];
    [self.contentView addSubview:line];
    line.frame = CGRectMake(10, self.height - 1, self.width - 10, 1);
    
}
@end
