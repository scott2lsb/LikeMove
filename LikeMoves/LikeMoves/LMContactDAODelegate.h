//
//  LMContactDAODelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMContactDAODelegate <NSObject>
@optional
-(void)getSportRankSuccess:(NSArray*)rank;
-(void)getFriendsSuccess:(NSArray*)friends;
-(void)getCrowdfundFriendSuccess:(NSArray*)friends;
-(void)getAcceptFriendSuccess:(NSArray*)friends;
-(void)scanFriendSuccess:(NSArray*)scanFriend;
-(void)addFriendByPhoneSuccess:(NSInteger)status;
-(void)acceptFriendSuccess;
-(void)addFriendByIDSuccess:(NSInteger)status;
-(void)delFriendByIDSuccess:(NSInteger)status;
@end
