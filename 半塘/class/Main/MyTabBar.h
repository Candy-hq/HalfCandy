//
//  MyTabBar.h
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)();

@interface MyTabBar : UITabBar

@property (nonatomic,copy) ClickBlock clickBlock;

@end
