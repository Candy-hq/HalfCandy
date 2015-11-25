//
//  HomeProjectHeaderView.m
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeProjectHeaderView.h"
#import "UIColor+AddColor.h"

@implementation HomeProjectHeaderView

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
    self.pic = [[UIImageView alloc]init];
    [self addSubview:self.pic];
    
   self.mask = [[UIImageView alloc]init];
    self.mask.layer.cornerRadius = 10;
    self.mask.clipsToBounds = YES;
    self.mask.alpha = 0.15;
    self.mask.image = [UIImage imageNamed:@"hudsonBackground"];
    [self.pic addSubview:self.mask];
    
    self.title = [[UILabel alloc]initWithTitle:nil textColor:[UIColor whiteColor]];
    [self.pic addSubview:self.title];
    
    self.content = [[UILabel alloc]initWithTitle:nil textColor:[UIColor shenhuiseColor]];
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.numberOfLines = 0;
    [self addSubview:self.content];
}
@end
