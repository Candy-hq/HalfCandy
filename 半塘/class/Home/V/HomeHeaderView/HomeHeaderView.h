//
//  HomeHeaderView.h
//  半塘
//
//  Created by Candy on 15/11/19.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeLIst;

typedef void(^ListBlock)(HomeLIst *);

@interface HomeHeaderView : UIView

@property (nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,strong) UICollectionView *listView;

@property (nonatomic,copy) ListBlock listBlock;
@end
