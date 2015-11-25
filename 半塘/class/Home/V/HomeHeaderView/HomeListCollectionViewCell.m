//
//  HomeListCollectionViewCell.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListCollectionViewCell.h"

@interface HomeListCollectionViewCell ()


@end

@implementation HomeListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.width - 10, self.height - 10)];
        self.pic.userInteractionEnabled = YES;
        [self.contentView addSubview:self.pic];
        
    }
    return self;
}

@end
