//
//  SearchDetailView.m
//  半塘
//
//  Created by Candy on 15/11/22.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import "SearchDetailView.h"
#import "HomeListSelectView.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation SearchDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        self.contentSize = CGSizeMake(kScreenWith * 2, 0);
        self.pagingEnabled = YES;
        
    }
    return self;
}

- (void)initSubviews
{
    HomeListSelectView *selectView = [[HomeListSelectView alloc]init];
    selectView.backgroundColor = [UIColor whiteColor];
    selectView.label_1.text = @"单品";
    selectView.label_2.text = @"专题";
    selectView.frame = CGRectMake(0, 0, kScreenWith, 40);
    [self addSubview:selectView];
    
    // collectView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWith / 2 - 30 , kScreenWith / 2 - 30);
    
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:(CGRectMake(selectView.x, selectView.y + selectView.height , kScreenWith, kScreenHeight - selectView.y + selectView.height)) collectionViewLayout:layout];
    collectView.backgroundColor = [UIColor redColor];
    [self addSubview:collectView];
    
    // tableView
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:(CGRectMake(kScreenWith, collectView.y, collectView.width, collectView.height)) style:(UITableViewStylePlain)];
    [self addSubview:tableView];
    tableView.backgroundColor = [UIColor yellowColor];
}
@end
