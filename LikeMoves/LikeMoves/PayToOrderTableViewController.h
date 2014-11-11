//
//  PayToOrderTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"


@interface PayToOrderTableViewController : UITableViewController<LMShopBLDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userBalance;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *deduction;
@property (weak, nonatomic) IBOutlet UILabel *realPrice;
@property (strong,nonatomic) LMShopBL* bl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelPay;

- (IBAction)cancelPayTo:(id)sender;
@property NSDictionary* dict;
@end
