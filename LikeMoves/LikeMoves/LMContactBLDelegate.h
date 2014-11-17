//
//  LMContactBLDelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMContactBLDelegate <NSObject>

@optional
-(void)getSportRankSuccess:(NSArray*)rank;
-(void)getFriendsSuccess:(NSArray*)friends;
/**
 *  获得众筹好友
 */
-(void)getCrowdfundFriendsSuccess:(NSArray*)friends;

-(void)getAcceptFriendSuccess:(NSArray*)friends;
-(void)scanFriendSuccess:(NSArray*)scanFriend;
-(void)addFriendByPhoneSuccess:(NSInteger)status;
-(void)acceptFriendSuccess;
-(void)addFriendByIDSuccess:(NSInteger)status;
@end
