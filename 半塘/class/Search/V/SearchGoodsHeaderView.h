//
//  SearchGoodsHeaderView.h
//  半塘
//
//  Created by Candy on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeProject;
@interface SearchGoodsHeaderView : UIView

@property (nonatomic,strong) HomeProject *data;


- (CGFloat)initSubviewsReturnHeight;

@end
