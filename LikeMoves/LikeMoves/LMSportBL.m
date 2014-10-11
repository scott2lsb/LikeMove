//
//  LMSportBL.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMSportBL.h"
@interface LMSportBL()

@end
@implementation LMSportBL
-(void)startMotionDetect{
    
    // 创建CLLocationManager对象
	self.locationManager = [[CLLocationManager alloc]init];
    _motionManager = [[CMMotionManager alloc] init];
    //	_motionManager.showsDeviceMovementDisplay = YES;
	_motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
	[_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical];
    px = py = pz = 0;
    pastSteps=0;
    
    
    // 如果定位服务可用
	if([CLLocationManager locationServicesEnabled])
	{
		NSLog( @"开始执行定位服务" );
		// 设置定位精度：最佳精度
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		// 设置距离过滤器为50米，表示每移动50米更新一次位置
		self.locationManager.distanceFilter = kCLDistanceFilterNone;
		// 将视图控制器自身设置为CLLocationManager的delegate
		// 因此该视图控制器需要实现CLLocationManagerDelegate协议
		self.locationManager.delegate = self;
		// 开始监听定位信息
		[self.locationManager startUpdatingLocation];
	}
	else
	{
		NSLog( @"无法使用定位服务！" );
	}
    
    //_________________________________
    /* 设置采样的频率，单位是秒 */
    NSTimeInterval updateInterval = 0.1; // 每秒采样20次
    
    //    __block int stepCount = 0; // 步数
    //在block中，只能使用weakSelf。
    /* 判断是否加速度传感器可用，如果可用则继续 */
    if ([_motionManager isAccelerometerAvailable] == YES) {
        /* 给采样频率赋值，单位是秒 */
        [_motionManager setAccelerometerUpdateInterval:updateInterval];
        //        _sportTimeCount=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sportTimeCount:) userInfo:nil repeats:YES];
        /* 加速度传感器开始采样，每次采样结果在block中处理 */
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             float xx = accelerometerData.acceleration.x;
             float yy = accelerometerData.acceleration.y;
             float zz = accelerometerData.acceleration.z;
             
             float dot = (px * xx) + (py * yy) + (pz * zz);
             float a = ABS(sqrt(px * px + py * py + pz * pz));
             float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
             
             dot /= (a * b);
             
             if (dot <= 0.82) {
                 if (!isSleeping) {
                     if (!isChange) {
                         _sportTimeCount=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sportTimeCount:) userInfo:nil repeats:YES];
                         isChange=YES;
                     }
                     /**
                      *  步数计数
                      */
                     isSleeping = YES;
                     [self performSelector:@selector(wakeUp) withObject:nil afterDelay:0.4];
                     numSteps += 1;
                     [_delegate stepCountChange:[NSString stringWithFormat:@"%d", numSteps]];
                 }
             }
             px = xx; py = yy; pz = zz;
         }
         ];
    }else{
        NSLog(@"加速器不可用");
        
    }
    _stopTimeCount=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stopTimeCount:) userInfo:nil repeats:YES];
    
}
- (void)wakeUp {
    isSleeping = NO;
}
// 成功获取定位数据后将会激发该方法
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
    // 获取最后一个定位数据
    //    CLLocation* location = [locations lastObject];
    // 依次获取CLLocation中封装的经度、纬度、高度、速度、方向等信息。
    //	self.latitudeTxt.text = [NSString stringWithFormat:@"%g",
    //                             location.coordinate.latitude];
    //	self.longitudeTxt.text = [NSString stringWithFormat:@"%g",
    //                              location.coordinate.longitude];
    //	self.altitudeTxt.text = [NSString stringWithFormat:@"%g",
    //                             location.altitude];
    //	self.speedTxt.text = [NSString stringWithFormat:@"%g",
    //                          location.speed];
    //	NSLog(@"~~~~%g" , location.speed);
    //	self.courseTxt.text = [NSString stringWithFormat:@"%g",
    //                           location.course];
}
// 定位失败时激发的方法
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"定位失败: %@",error);
}
#pragma mark - custom-method
-(void) stopTimeCount:(NSTimer*) timer{
    if (numSteps<=pastSteps) {
        [_sportTimeCount invalidate];
        isChange=FALSE;
        
    }else{
        pastSteps=numSteps;
    }
}
-(void) sportTimeCount:(NSTimer*) timer{
    sportTime+=1;
    
    [_delegate sportTimeChange:sportTime];
}
/**
 *  将秒数转化为“xxxHxxS”
 *
 *  @param sec 秒数
 *
 *  @return “xxxHxxS”式样的字符串
 */
-(NSString*) formatSecToString:(int) sec{
    int hour=sec/60;
    int second=sec%60;
    return [NSString stringWithFormat:@"%dH%dS",hour,second];
}
#pragma mark - 运动模块网络请求
/**
 *  添加运动时间，运动时长
 *
 *  @param duration 运动的时长，秒钟
 */
-(void) addMoveRecord:(NSTimeInterval)duration{
    
};
/**
 *  查询过去7天的运动记录，返回内容？
 *
 *  @param startTime 开始时间：2014-09-07
 *  @param endTime   结束时间：2014-09-07
 */
-(void) getMoveRecord:(NSString*)startTime withEndTime:(NSString*)endTime{
    
};
/**
 *  获得月份的运动天数
 *
 *  @param month @“2014-09”月份格式
 */
-(void) getMonthMoveDays:(NSString*)month{
    
};

@end
