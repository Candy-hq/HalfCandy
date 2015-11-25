//
//  SearchKeyDetailView.h
//  半塘
//
//  Created by Candy on 15/11/23.
//  Copyright © 2015年 汪汉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeListSelectView;

typedef void(^TableViewClick)(NSString *str);
typedef void(^CollectionViewClick)(NSString *str);



@interface SearchKeyDetailView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) HomeListSelectView *selectView;
@property (nonatomic,strong) UICollectionView *collectView;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *collectArr;
@property (nonatomic,strong) NSMutableArray *tableViewArr;

@property (nonatomic,copy) TableViewClick tableViewClick;
@property (nonatomic,copy) CollectionViewClick collectionClick;


@end
