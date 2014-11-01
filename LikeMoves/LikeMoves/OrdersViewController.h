//
//  OrdersViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-31.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
#import "HMSegmentedControl.h"
@interface OrdersViewController : UIViewController<LMShopBLDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray* noPayArray;
@property(strong,nonatomic)NSArray* paidArray;
@property(strong,nonatomic)NSArray* sendArray;
@property(strong,nonatomic)NSArray* receivedArray;
@property(strong,nonatomic)UITableView* noPayTableView;
@property(strong,nonatomic)UITableView* paidTableView;
@property(strong,nonatomic)UITableView* sendTableView;
@property(strong,nonatomic)UITableView* receivedTableView;
@property(strong,nonatomic)UIScrollView* scrollView;
@property(strong,nonatomic)HMSegmentedControl*segmentedControl;
@property(strong,nonatomic)LMShopBL* bl;
@end
