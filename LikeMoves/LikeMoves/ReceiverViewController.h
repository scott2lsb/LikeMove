//
//  ReceiverViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
@interface ReceiverViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LMShopBLDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray* receivers;
@property(strong,nonatomic)LMShopBL* bl;
@end
