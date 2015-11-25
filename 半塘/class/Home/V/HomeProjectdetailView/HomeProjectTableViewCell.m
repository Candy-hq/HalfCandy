//
//  HomeProjectTableViewCell.m
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeProjectTableViewCell.h"
#import "UIColor+AddColor.h"
#import "HomeProject.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeProjectTableViewCell ()




@end

@implementation HomeProjectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.number = [[UILabel alloc]initWithTitle:nil textColor:honse];
    self.number.frame = CGRectMake(10, 10, 30, 30);
    self.number.layer.borderWidth = 1;
    self.number.layer.borderColor = honse.CGColor;
    self.number.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.number];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    [self.contentView addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.frame = CGRectMake(self.number.x + self.number.width + 10, 10, [UIScreen mainScreen].bounds.size.width - (self.number.x + self.number.width + 10), 30);
    
    self.desc = [[UILabel alloc]initWithTitle:nil textColor:[UIColor grayColor]];;
    [self.contentView addSubview:self.desc];
    self.desc.font = [UIFont systemFontOfSize:14];
    
    
}

-(void)setData:(HomeProject *)data
{
    _data = data;
    self.title.text = data.title;
    self.desc.text = data.desc;
    
//    self.number.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    self.title.text = data.title;
    self.desc.text = data.desc;
    
    self.desc.frame = CGRectMake(self.number.x, self.number.y + self.number.height + 10, kScreenWidth - 2 * self.number.x, 20);
    self.desc.numberOfLines = 0;
    [self.desc sizeToFit];

    
    self.desc.frame = CGRectMake(self.number.x, self.number.y + self.number.height + 10, kScreenWidth - 2 * self.number.x, 20);
    self.desc.numberOfLines = 0;
    [self.desc sizeToFit];
    
    for (int i = 0; i < data.picArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:(CGRectMake(self.desc.x, self.desc.height + self.desc.y + 10 + (self.desc.width * i), self.desc.width, self.desc.width))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:data.picArr[i]]];
        [self.contentView addSubview:imageView];
    }

}

@end
