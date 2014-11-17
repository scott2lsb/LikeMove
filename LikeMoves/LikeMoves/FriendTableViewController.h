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
#import "HMSegmentedControl.h"
#import "LMShopBL.h"
#import "LMShopBLDelegate.h"
#import "User.h"
#import "RTSpinKitView.h"
@interface FriendTableViewController : UIViewController<LMContactBLDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,LMShopBLDelegate>
@property (strong,nonatomic) LMContactBL* bl;
@property(strong,nonatomic)LMShopBL* shopBL;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)UITableView* crowdfundFriendTableView;

@property(nonatomic,strong) ShowNewFriendsCountBlock friendsBlock;
- (IBAction)searchFriend:(id)sender;


@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)HMSegmentedControl* segmentedControl;
@property(nonatomic,strong)NSMutableArray* rankFriends;
@property(nonatomic,strong)NSMutableArray* crowdfundFriends;;
@end
