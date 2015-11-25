//
//  HotSearchView.h
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StrBlcok)(NSString *str);

@interface HotSearchView : UIView

@property (nonatomic,strong) NSArray *hotArr;

- (void)initSubViews;

@property (nonatomic,copy) StrBlcok strBlcok;

@end
