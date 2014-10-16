//
//  LMSportBL.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSportBLDelegate.h"
#import "LMSportDAODelegate.h"
#import "SportDAO.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
@interface LMSportBL : NSObject<CLLocationManagerDelegate,LMSportDAODelegate>{
    float px;
    float py;
    float pz;
    
    int numSteps;
    int pastSteps;
    
    BOOL isChange;
    BOOL isSleeping;
    BOOL timeCharge;
    int sportTime;//运动时长
}
@property (strong,nonatomic)CLLocationManager *locationManager;
@property (strong,nonatomic)CMMotionManager *motionManager;
@property (nonatomic) NSTimer* stopTimeCount;
@property (nonatomic) NSTimer* sportTimeCount;

-(void)startMotionDetect;
#pragma mark - 运动网络接口
@property (weak, nonatomic) id <LMSportBLDelegate> delegate;
@property (strong,nonatomic)SportDAO* dao;
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
-(void) getMoveWeekRecords;
/**
 *  获得月份的运动天数
 *
 *  @param month @“2014-09”月份格式
 */
-(void) getMonthMoveDays:(NSString*)month;

@end
