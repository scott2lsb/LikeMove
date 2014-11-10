//
//  ShopCartConfirmTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-10.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
@interface ShopCartConfirmTableViewController : UITableViewController<UITextFieldDelegate,LMShopBLDelegate>
@property (weak, nonatomic) IBOutlet UILabel *receiverName;
@property (weak, nonatomic) IBOutlet UILabel *receiverPhone;
@property (weak, nonatomic) IBOutlet UILabel *receiverAdr;

@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *maxDeduction;
@property (weak, nonatomic) IBOutlet UITextField *coinNum;
@property (weak, nonatomic) IBOutlet UILabel *deduction;
@property (weak, nonatomic) IBOutlet UILabel *sumCoins;
@property (weak, nonatomic) IBOutlet UILabel *realPrice;
@property NSDictionary* detail;
- (IBAction)confirmTo:(id)sender;

@property NSString* receiverID;
@property (strong,nonatomic) LMShopBL* bl;
@end
