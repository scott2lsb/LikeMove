//
//  LMFriendBL.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMContactBLDelegate.h"
#import "LMContactDAODelegate.h"
#import "ContactDAO.h"
@interface LMContactBL : NSObject<LMContactDAODelegate>

@property (weak,nonatomic) id<LMContactBLDelegate> delegate;
@property (strong,nonatomic)    ContactDAO* dao;

-(void)findFriendByID:(NSString*)friendID;
-(void)findFriendByPhone:(NSString*)phone;

-(void)addFriendByID:(NSString*)friendID;
-(void)addFriendByPhone:(NSString*)phone;
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
-(void)scanFriend:(NSString*)longitude withLatitude:(NSString*)latitude;
-(void)stopScanFriend;
/**
 *  获得好友运动排行
 *
 *  @param date 运动排行的日期
 */
-(NSArray*)getFriendSportRank:(NSString*)date;
@end
