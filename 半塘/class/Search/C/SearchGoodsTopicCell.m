//
//  SearchGoodsTopicCell.m
//  半塘
//
//  Created by Candy on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchGoodsTopicCell.h"
#import "UILabel+Extension.h"
#import "UIColor+AddColor.h"

@implementation SearchGoodsTopicCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.width, self.height - 30))];
    [self.contentView addSubview:self.pic];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    [self.contentView addSubview:self.title];
    
    self.title.frame = CGRectMake(self.pic.x, self.pic.y + self.pic.height , self.width - self.pic.x * 2, 30);
    self.title.font = [UIFont systemFontOfSize:15];
}
@end
