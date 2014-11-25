//
//  AcceptFriendViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-10.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMContactBL.h"
#import "LMContactBLDelegate.h"
#import "RTSpinKitView.h"
#import "AcceptFriendTableViewCell.h"
@interface AcceptFriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LMContactBLDelegate,AcceptFriendCellDelegate>{
    NSMutableArray* acceptFriends;
}
@property (weak, nonatomic) IBOutlet UITableView *acceptFriend;
@property (strong,nonatomic) LMContactBL* bl;
@property RTSpinKitView* spinner;
- (IBAction)acceptFriend:(id)sender;
@end
