//
//  UIBarButtonItem+Extension.m
//  微博
//
//  Created by Candy on 15/11/13.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    
    btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
