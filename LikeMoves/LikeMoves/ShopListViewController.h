//
//  ShopListViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-21.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBLDelegate.h"
#import "LMShopBL.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ShopListViewController : UIViewController<LMShopBLDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) LMShopBL* bl;
@property(strong)NSArray* products;
@property (weak, nonatomic) IBOutlet UIButton *companyIntro;
@property (weak, nonatomic) IBOutlet UIButton *companyMap;

//界面元素
@property (weak, nonatomic) IBOutlet UITableView *productTable;

- (IBAction)pushToShopCart:(id)sender;
@end
