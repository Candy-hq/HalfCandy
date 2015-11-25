//
//  HomeListTableViewCell.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListTableViewCell.h"
#import "UIColor+AddColor.h"
#import "HomeListDesData.h"
#import "UIImageView+WebCache.h"


#define kScreenWith [UIScreen mainScreen].bounds.size.width

@interface HomeListTableViewCell ()

@property (nonatomic,strong) UIImageView *author_icon;
@property (nonatomic,strong) UILabel *author_name;
@property (nonatomic,strong) UILabel *datastr;
@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIImageView *recommend;
@property (nonatomic,strong) UIView *bottom;

@property (nonatomic,strong) UIView *btnTop;
@property (nonatomic,strong) UIButton *share;
@property (nonatomic,strong) UIView * one;
@property (nonatomic,strong) UIButton *rating;
@property (nonatomic,strong) UIView * two;
@property (nonatomic,strong) UIButton *like;



@end

@implementation HomeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    
    self.author_icon = [[UIImageView alloc]initWithFrame:(CGRectMake(10, 10, 40, 40))];
    self.author_icon.layer.cornerRadius = 20;
    self.author_icon.clipsToBounds = YES;
    [self.contentView addSubview:self.author_icon];
    
    // 关注
    UIButton *focus = [[UIButton alloc]init];
    focus.frame = CGRectMake(kScreenWith - 60 - 10 , self.author_icon.y + 10, 60, 20);
    focus.layer.cornerRadius = 8;
    focus.layer.borderWidth = 1;
    focus.layer.borderColor = [UIColor carrotColor].CGColor;
    [focus setTitle:@"关注" forState:(UIControlStateNormal)];
    [focus setTitleColor:[UIColor carrotColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:focus];
    
    // recommend
    
    self.recommend = [[UIImageView alloc]initWithFrame:(CGRectMake(focus.x - 50, focus.y - 5 , 30, 30))];
    self.recommend.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:132 / 255.0 blue:134 / 2550. alpha:1.0];
    self.recommend.layer.cornerRadius = 15;
    self.recommend.image = [UIImage imageNamed:@"attach_28"];
    [self.contentView addSubview:self.recommend];
    
    //
    self.author_name = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    self.author_name.frame = CGRectMake(self.author_icon.x + self.author_icon.width + 10, self.author_icon.y, kScreenWith - 2 * (self.author_icon.x + self.author_icon.width + 10), 20);
    self.author_name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.author_name];
    
    //
    self.datastr = [[UILabel alloc]initWithTitle:nil textColor:[UIColor grayColor]];
    [self.contentView addSubview:self.datastr];
    self.datastr.frame = CGRectMake(self.author_name.x, self.author_name.y + self.author_name.height, self.author_name.width, self.author_name.height);
    self.datastr.font = [UIFont systemFontOfSize:14];
    
    //
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(0, self.author_icon.y + self.author_icon.height + 20, kScreenWith, kScreenWith))];
    [self.contentView addSubview:self.pic];
    
    //
    self.content = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    [self.contentView addSubview:self.content];
    
    {
        UIView *aa = [[UIView alloc]init];
        aa.backgroundColor = [UIColor huiseColor];
        [self.contentView addSubview:aa];
        self.btnTop = aa;
        
        self.share = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.share setImage:[UIImage imageNamed:@"iconfont-fenxiang-2"] forState:(UIControlStateNormal)];
        self.share.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.share setTitle:@"分享" forState:(UIControlStateNormal)];
        [self.share setTitleColor:[UIColor shenhuiseColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.share];
        
        self.one = [[UIView alloc]init];
        self.one.backgroundColor = [UIColor huiseColor];
        [self.contentView addSubview:self.one];
        
        self.rating = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.rating.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.rating setImage:[UIImage imageNamed:@"iconfont-pinglun"] forState:(UIControlStateNormal)];
        [self.rating setTitle:@"评论" forState:(UIControlStateNormal)];
        [self.rating setTitleColor:[UIColor shenhuiseColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.rating];
        
        self.two = [[UIView alloc]init];
        self.two.backgroundColor = [UIColor huiseColor];
        [self.contentView addSubview:self.two];
        
        self.like = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.like.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.like setImage:[UIImage imageNamed:@"bs_feed_action_praise"] forState:(UIControlStateNormal)];
        [self.like setTitle:nil forState:(UIControlStateNormal)];
        [self.like setTitleColor:[UIColor shenhuiseColor] forState:(UIControlStateNormal)];

        [self.contentView addSubview:self.like];
        
 
    }

    //底部
    UIView *bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor huiseColor];
    [self.contentView addSubview:bottom];
    self.bottom = bottom;

}


-(void)setData:(HomeListDesData *)data
{
    _data = data;
        //
    if (!data.avatar) {
        
        [self.author_icon sd_setImageWithURL:[NSURL URLWithString:data.avatar]];
    }
    self.author_name.text = data.username;
    self.datastr.text = data.datestr;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:data.picURL]];
    
    self.content.frame = CGRectMake(self.author_icon.x, self.pic.y + self.pic.height + 10, kScreenWith - 2 * (self.author_icon.x), 20);
    self.content.text = data.content;
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.numberOfLines = 0;
    [self.content sizeToFit];
    
    
    {
        self.btnTop.frame = CGRectMake(0, self.content.y + self.content.height +5, kScreenWith, 1);
        self.share.frame = CGRectMake(0, self.content.y + self.content.height + 10, kScreenWith / 3, 30);
    
        self.one.frame = CGRectMake(kScreenWith / 3, self.share.y + 5, 1, self.share.height -10);
        self.rating.frame = CGRectMake(kScreenWith / 3, self.content.y + self.content.height + 10, kScreenWith / 3, 30);

        self.two.frame = CGRectMake(kScreenWith * 2 / 3, self.share.y + 5, 1, self.share.height -10);

        self.like.frame = CGRectMake(kScreenWith * 2 / 3 , self.content.y + self.content.height + 10, kScreenWith / 3, 30);

        self.bottom.frame = CGRectMake(0, self.share.y + self.share.height + 10, kScreenWith, 10);
    }
    if ([data.is_recommend isEqualToString:@"1"]) {
        self.recommend.hidden = NO;
    }else
    {
        self.recommend.hidden = YES;
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
