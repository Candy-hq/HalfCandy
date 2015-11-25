//
//  SearchData.m
//  半塘
//
//  Created by Candy on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
