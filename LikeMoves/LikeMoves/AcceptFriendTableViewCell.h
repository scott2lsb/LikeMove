//
//  AcceptFriendTableViewCell.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-25.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AcceptFriendCellDelegate;
@interface AcceptFriendTableViewCell : UITableViewCell
@property UILabel* nickname;
@property UILabel* phone;
@property UIButton* acceptBtn;
@property UIButton* rejectBtn;
@property (nonatomic, assign) long index;
@property(nonatomic,assign) long section;

// 代理一般用assign，因为一般情况下代理是控制器
@property (nonatomic, assign) id<AcceptFriendCellDelegate> delegate;
@end
@protocol AcceptFriendCellDelegate <NSObject>
- (void)AcceptFriendCellBtnClick:(AcceptFriendTableViewCell *)cell;
-(void)RejectFriendCellBtnClick:(AcceptFriendTableViewCell *)cell;
@end