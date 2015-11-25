//
//  HomeProject.m
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeProject.h"

@implementation HomeProject

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"pic"]) {
        for (NSDictionary *dic in value) {
            [self.picArr addObject:dic[@"pic"]];
        }
    }
    
}

-(NSMutableArray *)picArr
{
    if (!_picArr) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

@end
