//
//  HomeCollectionViewCell.m
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageV = [[UIImageView alloc]init];
        self.imageV.frame = self.bounds;
        self.imageV.userInteractionEnabled = YES;
        self.imageV.clipsToBounds = YES;
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageV];
    }
    return self;
}

@end
