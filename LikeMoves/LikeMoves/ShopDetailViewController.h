//
//  ShopDetailViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-27.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
@interface ShopDetailViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *productDetail;
@property(nonatomic)UIScrollView* imgDetail;
@property(nonatomic)UITableView* comment;
//轮播图
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScroll;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sizeSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSeg;
@end
