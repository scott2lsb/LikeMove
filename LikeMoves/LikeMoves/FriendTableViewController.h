//
//  FriendTableViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-4.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTumblrMenuView.h"
#import "LMContactBLDelegate.h"
#import "LMContactBL.h"
#import <SMS_SDK/SMS_SDKResultHanderDef.h>
@interface FriendTableViewController : UIViewController<LMContactBLDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) LMContactBL* bl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) ShowNewFriendsCountBlock friendsBlock;
- (IBAction)searchFriend:(id)sender;

@end
