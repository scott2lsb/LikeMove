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


@property (weak, nonatomic) id <LMSportBLDelegate> delegate;
@property (weak,nonatomic)SportDAO* dao;

-(void)startMotionDetect;
@end
