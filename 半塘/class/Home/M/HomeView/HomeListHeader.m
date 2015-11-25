//
//  HomeListHeader.m
//  半塘
//
//  Created by Candy on 15/11/20.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListHeader.h"

@implementation HomeListHeader



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.description1 = value;
    }
    if ([key isEqualToString:@"author"])
    {
        self.author_username = value[@"username"];
        self.author_avatar = value[@"avatar"];
        
    }
}

@end
