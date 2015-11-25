//
//  HomeListCollectHeaderView.h
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeListCollectHeaderRankView;

@interface HomeListCollectHeaderView : UIView

@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UIImageView *authorIcon;
@property (nonatomic,strong) UILabel *usernameLB;
@property (nonatomic,strong) UILabel *dataLB;
@property (nonatomic,strong) UILabel *desLB;

@property (nonatomic,strong) HomeListCollectHeaderRankView *rankView;



@end
