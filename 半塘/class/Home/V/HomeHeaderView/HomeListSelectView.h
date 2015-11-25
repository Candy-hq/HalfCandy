//
//  HomeListSelectView.h
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)();
@interface HomeListSelectView : UIView

@property (nonatomic,strong) UILabel *label_1;
@property (nonatomic,strong) UILabel *label_2;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,copy) ClickBlock click_1;
@property (nonatomic,copy) ClickBlock click_2;

@end
