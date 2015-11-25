//
//  HomePhoneViewCell.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.width


#import "HomePhoneViewCell.h"

@implementation HomePhoneViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth - 10,160)];
        self.photo.layer.cornerRadius = 10;
        self.photo.clipsToBounds = YES;
        [self.contentView addSubview:self.photo];
        
    
        UIImageView *maskV = [[UIImageView alloc]initWithFrame:(CGRectMake(5, 160 - 30, kScreenWidth - 10, 35))];
        maskV.layer.cornerRadius = 10;
        maskV.clipsToBounds = YES;
        maskV.alpha = 0.15;
        maskV.image = [UIImage imageNamed:@"hudsonBackground"];
        [self addSubview:maskV];
        
        self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor whiteColor]];
        [self addSubview:self.title];
        self.title.x = maskV.x + 10;
        self.title.y = maskV.y + 5;
        self.title.width = maskV.width - 10;
        self.title.height = maskV.height - 5;
        
        UIImageView *heartMask = [[UIImageView alloc]initWithFrame:(CGRectMake(kScreenWidth - 35 - 10, 10, 35, 35))];
        heartMask.image = [UIImage imageNamed:@"hudsonBackground"];
        heartMask.layer.borderWidth = 1;
        heartMask.layer.cornerRadius = 5;
        heartMask.clipsToBounds = YES;
        heartMask.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:heartMask];
        
        UIImageView *heart = [[UIImageView alloc]init];
        heart.image = [UIImage imageNamed:@"bs_feed_action_praise_red"];
        heart.frame = CGRectMake(8, 5, 20, 16);
        [heartMask addSubview:heart];
        
        self.count = [[UILabel alloc]initWithTitle:nil textColor:[UIColor whiteColor]];
        self.count.frame = CGRectMake(0, heartMask.height - 15, heartMask.width, 15);
        self.count.font = [UIFont systemFontOfSize:10];
        self.count.textAlignment = NSTextAlignmentCenter;
        [heartMask addSubview:self.count];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
