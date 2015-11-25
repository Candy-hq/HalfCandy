//
//  SearchGoodsHeaderView.m
//  半塘
//
//  Created by Candy on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#import "SearchGoodsHeaderView.h"
#import "UIColor+AddColor.h"
#import "HomeProject.h"
#import "UIImageView+WebCache.h"

@implementation SearchGoodsHeaderView

-(void)setData:(HomeProject *)data
{
    _data = data;
    
    [self initSubviewsReturnHeight];

}


- (CGFloat)initSubviewsReturnHeight
{
    
    UILabel *title = [[UILabel alloc]initWithTitle:self.data.title textColor:[UIColor shenhuiseColor]];
    title.frame = CGRectMake(10, 10, kScreenWidth - 20, 30);
    title.font = [UIFont systemFontOfSize:18];
    [self addSubview:title];
    
    UILabel *desc = [[UILabel alloc]initWithTitle:self.data.desc textColor:[UIColor grayColor]];
    desc.font = [UIFont systemFontOfSize:15];
    [self addSubview:desc];
    CGRect rect = [self.data.desc boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * title.x, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    desc.frame = CGRectMake(title.x, title.y + title.height + 5, kScreenWidth - 2 * title.x, rect.size.height);
    desc.numberOfLines = 0;
    
    
    for (int i = 0; i < self.data.picArr.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(desc.x, desc.y + desc.height + 10 + ((desc.width + 3) * i), desc.width, desc.width)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.data.picArr[i]]];
        [self addSubview:imageView];
    }
 
    CGFloat height = desc.y + desc.height + self.data.picArr.count * (desc.width + 10);
    return height;
}


@end
