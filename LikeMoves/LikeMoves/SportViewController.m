//
//  SportViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-22.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportViewController.h"
#import "UIColor+FlatUI.h"
@interface SportViewController ()
@property (nonatomic) NSTimer* stopTimer;
@property (nonatomic) NSTimer* countSportTime;
@end

@implementation SportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
     逻辑层实例化
     */
    _bl=[[LMSportBL alloc]init];
    _bl.delegate=self;
    [_bl startMotionDetect];
    /**
     能量环
     */
    _wdSport = [[wendu_yuan2 alloc]initWithFrame:self.sportCircle.bounds];
    _wdSport.backgroundColor = [UIColor whiteColor];
    [self.sportCircle addSubview:_wdSport];
    //    [_sportCircle bringSubviewToFront:_wdSport];
    //    _wdSport.z=1;
    /**
     *  界面元素
     */
    [_stepImg setImage:[UIImage imageNamed:@"step"]];
    
    
    _fireBtn = [[DKCircleButton alloc] initWithFrame:CGRectMake(95, 100, 130, 130)];
    
    //    _fireBtn.center = CGPointMake(160, 200);
    _fireBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [_fireBtn setTitleColor:[UIColor peterRiverColor] forState:UIControlStateNormal];
    [_fireBtn setTitleColor:[UIColor peterRiverColor]  forState:UIControlStateSelected];
    [_fireBtn setTitleColor:[UIColor peterRiverColor] forState:UIControlStateHighlighted];
    [self setFireBtnTitle:@"0"];
    
    [_wdSport addSubview:_fireBtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SportDelegate
-(void) stepCountChange:(NSString *)stepCount {
    _stepCount.text=stepCount;
    
    
    _wdSport.z=[stepCount doubleValue]/100;
}
-(void)sportTimeChange:(int)sportTime{
    int hour=sportTime/60;
    int second=sportTime%60;
    [self setFireBtnTitle:[NSString stringWithFormat:@"%dm%ds",hour,second]];
}
#pragma mark - custom-method
-(void) setFireBtnTitle:(NSString*) title{
    [_fireBtn setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
    [_fireBtn setTitle:NSLocalizedString(title, nil) forState:UIControlStateSelected];
    [_fireBtn setTitle:NSLocalizedString(title, nil) forState:UIControlStateHighlighted];
}
//-(void)stopSportCount:(NSTimer*) timer{
//    [_countSportTime invalidate];
//}
@end
