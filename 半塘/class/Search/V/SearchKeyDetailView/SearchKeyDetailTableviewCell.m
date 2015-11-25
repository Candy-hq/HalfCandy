//
//  SearchKeyDetailTableviewCell.m
//  半塘
//
//  Created by Candy on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchKeyDetailTableviewCell.h"
#import "UIColor+AddColor.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height



@implementation SearchKeyDetailTableviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(10, 15, kScreenWith - 20, kScreenHeight / 3 - 15))];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    self.pic = [[UIImageView alloc]initWithFrame:(CGRectMake(10, 10, view.width - 20, view.height - 20 - 20))];
    [view addSubview:self.pic];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];\
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.frame = CGRectMake(0, view.height - 30, view.width, 30);
    [view addSubview:self.title];
    
//    self.pic.backgroundColor = [UIColor cyanColor];
//    self.title.backgroundColor = [UIColor redColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
