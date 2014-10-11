//
//  SportRankViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-9.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMContactBLDelegate.h"
#import "LMContactBL.h"
@interface SportRankViewController : UITableViewController<LMContactBLDelegate>
@property (strong,nonatomic) LMContactBL* bl;

- (IBAction)back:(id)sender;

@end
