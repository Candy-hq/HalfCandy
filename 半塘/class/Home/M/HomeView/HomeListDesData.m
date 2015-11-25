//
//  HomeListDesData.m
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "HomeListDesData.h"

@implementation HomeListDesData

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"author"])
    {
        self.avatar = value[@"avatar"];
        self.username = value[@"username"];
    }
    if ([key isEqualToString:@"pics"]) {
        self.picURL = value[0][@"url"];
    }
    
    if ([key isEqualToString:@"tags"]) {
        for (NSDictionary *obj in value) {
            [self.tagArr addObject:obj];
        }
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

-(NSArray *)tagArr
{
    if (!_tagArr) {
        _tagArr = [NSMutableArray array];
    }
    return _tagArr;
}
@end
