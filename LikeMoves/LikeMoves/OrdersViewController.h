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
#import "ReceiverOrderDetailTableViewController.h"
#import "SendOrderTableViewController.h"
@interface OrdersViewController : UIViewController<LMShopBLDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray* noPayArray;
@property(strong,nonatomic)NSMutableArray* paidArray;
@property(strong,nonatomic)NSMutableArray* sendArray;
@property(strong,nonatomic)NSMutableArray* receivedArray;
@property(strong,nonatomic)UITableView* noPayTableView;
@property(strong,nonatomic)UITableView* paidTableView;
@property(strong,nonatomic)UITableView* sendTableView;
@property(strong,nonatomic)UITableView* receivedTableView;
@property(strong,nonatomic)UIScrollView* scrollView;
@property(strong,nonatomic)HMSegmentedControl*segmentedControl;
@property(strong,nonatomic)LMShopBL* bl;
@end
