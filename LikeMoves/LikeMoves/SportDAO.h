//
//  SportDAO.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LMSportDAODelegate.h"
#import "JSONKit.h"
#import "User.h"
@interface SportDAO : NSObject
@property (strong,nonatomic) id<LMSportDAODelegate> delegate;
/**
 *  添加金币
 *
 *  @param coinsNum 要添加的金币数量
 */
-(void)addCoins:(NSString*)coinsNum;
/**
 *  添加运动时间，运动时长
 *
 *  @param duration 运动的时长，秒钟
 */
-(void) addMoveRecord:(NSTimeInterval)duration withSteps:(NSInteger)steps;
/**
 *  查询过去7天的运动记录，返回内容？
 *
 *  @param startTime 开始时间：2014-09-07
 *  @param endTime   结束时间：2014-09-07
 */
-(void) getMoveWeekRecords:(NSString*)startTime withEndTime:(NSString*)endTime;
/**
 *  30天的运动时间
 *
 *  @param startDate 开始时间“2014-09-12”
 *  @param endDate   结束时间“2014-09-18”
 */
-(void)getThirtyDaysMoveWithStart:(NSString*)startDate end:(NSString*)endDate;
/**
 *  获得月份的运动天数
 *
 *  @param month @“2014-09”月份格式
 */
-(void) getMonthMoveDays:(NSString*)month;

@end
