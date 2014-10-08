//
//  ContactDAO.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMContactDAODelegate.h"
@interface ContactDAO : NSObject
@property(weak,nonatomic) id<LMContactDAODelegate> delegate;


-(void)findFriendByID:(NSString*)friendID;
-(void)findFriendByPhone:(NSString*)phone;

-(void)addFriend:(NSString*)friendID;
-(void)acceptFriend:(NSString*)friendID;
-(void)rejectFriend:(NSString*)friendID;
-(void)delFriend:(NSString*)friendID;
-(void)getFriends:(NSString*)page perPage:(NSString*)perPage;
-(void)getMyFriendRequests:(NSString*)page perPage:(NSString*)perPage;
/**
 *  我的待接受好友列表
 *
 *  @param page    分为page页
 *  @param perPage 每页有perPage项内容
 */
-(void)getMyAccepts:(NSString*)page perPage:(NSString*)perPage;
@end
