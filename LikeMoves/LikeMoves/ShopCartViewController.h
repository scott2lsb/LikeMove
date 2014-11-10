//
//  ShopCartViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShopCartConfirmTableViewController.h"
@interface ShopCartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LMShopBLDelegate>

@property(strong,nonatomic) LMShopBL* bl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *countNum;
@property (weak, nonatomic) IBOutlet UILabel *deductionNum;


- (IBAction)payTo:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end
