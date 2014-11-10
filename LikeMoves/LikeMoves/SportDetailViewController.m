//
//  SportDetailViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportDetailViewController.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "PNBar.h"
@interface SportDetailViewController ()

@end

@implementation SportDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMSportBL alloc] init];
    [_bl getMoveWeekRecords];
    _bl.delegate=self;
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
    barChartLabel.text = @"一星期运动量";
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:barChartLabel];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshCoinsAndMonthDays];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void) refreshCoinsAndMonthDays{
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM"];
//    //用[NSDate date]可以获取系统当前时间
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    [_bl getMonthMoveDays:currentDateStr];
    [_bl getThirtyDaysOfMove];
    //NSUserDefaults刷新金币数量，使用NSUserDefaults中的数据
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    _coinLabel.text=user.coins;
}
#pragma mark - PNBarDelegate
- (void)userClickedOnBarCharIndex:(NSInteger)barIndex
{
    
    DLog(@"Click on bar %@", @(barIndex));
    
//    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];
    
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue= @1.0;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.toValue= @1.1;
    
    animation.duration= 0.2;
    
    animation.repeatCount = 0;
    
    animation.autoreverses = YES;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeForwards;
    
//    [bar.layer addAnimation:animation forKey:@"Float"];
}

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    DLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    DLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}
#pragma mark - SportBLDelegate
-(void)getWeekRecordSuccess:(NSArray *)steps withWeeks:(NSArray *)weeks{
    CGFloat height;
    if ([[UIScreen mainScreen] bounds].size.height>500) {
        height=250.0;
    }else{
        height=200.0;
    }
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 120.0, SCREEN_WIDTH, height)];
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        NSString * labelText;
        if(yValue>600){
        int sporttime=yValue;
        int min=sporttime/60;

        labelText = [NSString stringWithFormat:@"%dm",min];
        }else{
            int sporttime=yValue;
            int min=sporttime/60;
            int sec=sporttime%60;
            labelText = [NSString stringWithFormat:@"%dm%ds",min,sec];

        }
        return labelText;
    };
    self.barChart.labelMarginTop = 15.0;

    self.barChart.yChartLabelWidth=35.0;

//    self.barChart.barWidth=10.0;
    //    self.barChart.barRadius=5.0;
    [self.barChart setXLabels:weeks];
    [self.barChart setYValues:steps];
    [self.barChart setStrokeColors:@[PNFreshGreen,PNFreshGreen,PNFreshGreen,PNFreshGreen,PNFreshGreen,PNFreshGreen,PNFreshGreen]];
    // Adding gradient
//    self.barChart.barColorGradientStart = [UIColor blueColor];
    
    [self.barChart strokeChart];
    self.barChart.delegate = self;
    

    [self.view addSubview:self.barChart];



}
-(void)getMonthMoveDaysSuccess:(NSInteger)days{

        _monthMoveDays.text=[NSString stringWithFormat:@"%ld天",(long)days];

}
- (IBAction)backTo:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES ];
}

- (IBAction)toMarket:(id)sender {
}
@end
