//
//  ContactDAO.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMContactDAODelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
@interface ContactDAO : NSObject{
//    NSArray* rankFriend;

}
@property(weak,nonatomic) id<LMContactDAODelegate> delegate;

/**
 *  通过好友id获得好友信息
 *
 *  @param friendID 好友id
 */
-(void)findFriendByID:(NSString*)friendID;
-(void)findFriendByPhone:(NSString*)phone;

#pragma mark - 好友模块网络请求
-(void)addFriendByID:(NSString*)friendID;
-(void)addFriendByPhone:(NSString*)phone;

-(void)acceptFriend:(NSString*)friendID;
-(void)rejectFriend:(NSString*)friendID;
-(void)delFriend:(NSString*)friendID;
-(void)getFriends:(NSString*)page perPage:(NSString*)perPage;
-(void)getMyFriendRequests:(NSString*)page perPage:(NSString*)perPage;

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
