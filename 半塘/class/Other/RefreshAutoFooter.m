//
//  RefreshAutoFooter.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "RefreshAutoFooter.h"

@implementation RefreshAutoFooter

- (void)prepare
{
    [super prepare];
    NSMutableArray *refresh = [NSMutableArray array];
    for (NSInteger i = 1; i<= 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [refresh addObject:image];
    }
    [self setImages:refresh forState:(MJRefreshStateWillRefresh)];
}
@end
