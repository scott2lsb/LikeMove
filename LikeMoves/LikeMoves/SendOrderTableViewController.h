//
//  SendOrderTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMShopBL.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SendOrderTableViewController : UITableViewController<UIAlertViewDelegate>
@property NSDictionary* dict;
@property LMShopBL* bl;
- (IBAction)confirmReceipt:(id)sender;

@end
