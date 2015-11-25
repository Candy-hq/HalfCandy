//
//  HomeProjectTableViewCell.h
//  半塘
//
//  Created by Candy on 15/11/21.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeProject;

@interface HomeProjectTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *number;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *desc;

@property (nonatomic,strong) HomeProject *data;
@end
