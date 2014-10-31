//
//  CrowdfundViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
#import "CrowdfundTableViewCell.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "User.h"
@interface CrowdfundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LMShopBLDelegate>
@property (strong,nonatomic)UITableView* givedTableView;
@property(strong,nonatomic)UITableView* receivedTableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,strong)HMSegmentedControl*segmentedControl;
@property(strong,nonatomic)NSArray* givedArray;
@property(strong,nonatomic)NSArray* receivedArray;
@property(strong,nonatomic)LMShopBL* bl;


- (IBAction)share:(id)sender;

@end
