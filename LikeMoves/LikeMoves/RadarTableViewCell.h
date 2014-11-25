//
//  RadarTableViewCell.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-25.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RadarCellDelegate;
@interface RadarTableViewCell : UITableViewCell
@property UILabel* nickname;
@property UILabel* phone;
@property UIButton* addFriendBtn;

@property (nonatomic, assign) long index;
@property(nonatomic,assign) long section;

// 代理一般用assign，因为一般情况下代理是控制器
@property (nonatomic, assign) id<RadarCellDelegate> delegate;
@end

@protocol RadarCellDelegate <NSObject>
- (void)RadarCellBtnClick:(RadarTableViewCell *)cell;
@end