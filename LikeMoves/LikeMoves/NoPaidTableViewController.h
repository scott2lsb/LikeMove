//
//  NoPaidTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayToOrderTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NoPaidTableViewController : UITableViewController
@property NSDictionary* dict;
- (IBAction)payToOrder:(id)sender;

@end
