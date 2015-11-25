
//
//  Product.m
//  半塘
//
//  Created by 葛宏兵 on 15/11/24.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "Product.h"

@implementation Product



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"item_id"]) {
        self.item_id = [NSString stringWithFormat:@"%@",value];
    }
    
}
@end
