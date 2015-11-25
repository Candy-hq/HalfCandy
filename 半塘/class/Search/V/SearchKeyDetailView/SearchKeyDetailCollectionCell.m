//
//  SearchKeyDetailCollectionCell.m
//  半塘
//
//  Created by Candy on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchKeyDetailCollectionCell.h"
#import "UIColor+AddColor.h"

@implementation SearchKeyDetailCollectionCell

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
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.width, self.height - 40))];
    
    [self.contentView addSubview:self.pic];
    
    UIImageView *maskView = [[UIImageView alloc]initWithFrame:CGRectMake(self.pic.width * 2 / 3 , self.pic.height - 20, self.pic.width / 3, 20)];
    maskView.image = [UIImage imageNamed:@"mengban"];
    maskView.alpha = 1.2;
    [self.contentView addSubview:maskView];
    
    self.price = [[UILabel alloc]initWithTitle:nil textColor:[UIColor whiteColor]];
    self.price.frame = CGRectMake(0, 0, maskView.width, 20);
    self.price.font = [UIFont systemFontOfSize:15];
    self.price.textAlignment = NSTextAlignmentCenter;
    [maskView addSubview:self.price];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    self.title.frame = CGRectMake(self.pic.x, self.pic.y + self.pic.height, self.pic.width, self.height - (self.pic.height + self.pic.y));
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.title];
    
    
//    self.pic.backgroundColor = [UIColor yellowColor];
//    self.title.backgroundColor = [UIColor blackColor];
//    self.price.backgroundColor = [UIColor cyanColor];
}
@end
