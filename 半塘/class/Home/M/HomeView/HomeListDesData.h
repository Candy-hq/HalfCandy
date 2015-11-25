//
//  HomeListDesData.h
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeListDesData : NSObject


/* 推荐标记 */
@property (nonatomic,strong) NSString *is_recommend;
/* iconURL */
@property (nonatomic,strong) NSString *avatar;
/* 用户名 */
@property (nonatomic,strong) NSString *username;
/* 时间 */
@property (nonatomic,strong) NSString *datestr;
/* 图片 */
@property (nonatomic,strong) NSString *picURL;
/* 内容 */
@property (nonatomic,strong) NSString *content;
/* tag数组 */
@property (nonatomic,strong) NSMutableArray *tagArr;
/* ID */
@property (nonatomic,strong) NSString *ID;



@end
