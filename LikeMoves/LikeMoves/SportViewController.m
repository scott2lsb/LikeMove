//
//  SportViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-22.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportViewController.h"
#import "UIColor+FlatUI.h"
#import "UMSocial.h"
#import "UMSocial_Sdk_Extra_Frameworks/UMSocial_ScreenShot_Sdk/UMSocialScreenShoter.h"
#import "WXApi.h"
#import "SMS_MBProgressHUD+Add.h"
#import "SMS_MBProgressHUD.h"
#define kCoinCountKey   100
#define mFireBtnH 120
@interface SportViewController ()
@property (nonatomic) NSTimer* stopTimer;
@property (nonatomic) NSTimer* countSportTime;
@end

@implementation SportViewController
static int kCal;
static int stepNum;
//static int coinNum;
static int sportSec;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sportCircleNumber=0.0;
    /**
     逻辑层实例化
     */
    _bl=[[LMSportBL alloc]init];
    _bl.delegate=self;
    _userBL=[[LMUserActBL alloc] init];
    [_userBL refreshMyself];
    [_bl startMotionDetect];
    /**
     能量环
     */
    _wdSport = [[wendu_yuan2 alloc]initWithFrame:self.sportCircle.bounds];
    _wdSport.backgroundColor = [UIColor whiteColor];
    [self.sportCircle addSubview:_wdSport];
    /**
     *  界面元素
     */
    
    
    
    _fireBtn = [[ZenPlayerButton alloc]initWithFrame:CGRectMake(self.sportCircle.bounds.size.width/2-mFireBtnH/2, self.sportCircle.bounds.size.height/2-mFireBtnH/2, mFireBtnH, mFireBtnH)];
    [_fireBtn addTarget:self action:@selector(sportCircleClear) forControlEvents:UIControlEventTouchUpInside];
    [self setSportTime:@"0m 0s"];
    
    
    
    [_wdSport addSubview:_fireBtn];
    [_wdSport addSubview:_coinImg];
    [_wdSport addSubview:_coinsCount];
    
    /**
     *  coins bags 福袋动画
     */
    _coinTagsArr = [NSMutableArray new];
    
    //主福袋层
    _bagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_hongbao_bags"]];
    _bagView.center = CGPointMake(CGRectGetMidX(self.view.frame) + 5, CGRectGetMidY(self.view.frame)+5 );
    
    
    /**
     *  使用自定义创建控件的方式使控件自适应，autolayout开启，在storyboard中建立的控件，必须已经显示才能在viewDidAppear中进行操作
     */
    if([UIScreen mainScreen].bounds.size.height<500){
        DLog(@"size-fit-test-3.5inch");
        _calCount=[[UILabel alloc]initWithFrame:CGRectMake(123 , 380, 77, 44)];
        _calCount.text=@"0千卡";
        _calCount.font=[UIFont systemFontOfSize:15];
        _calCount.textAlignment=NSTextAlignmentCenter;
        
        _calImg=[[UIImageView alloc] initWithFrame:CGRectMake(139, 342, 44, 44)];
        _calImg.image=[UIImage imageNamed:@"fire.png"];
        _calImg.contentMode=UIViewContentModeScaleToFill;
        [self.view addSubview:_calImg];
        [self.view addSubview:_calCount];
    }else{
        DLog(@"size-fit-test-4.0inch");
        _calCount=[[UILabel alloc]initWithFrame:CGRectMake(123, 419, 77, 44)];
        _calCount.text=@"0千卡";
        _calCount.font=[UIFont systemFontOfSize:15];
        _calCount.textAlignment=NSTextAlignmentCenter;
        
        _calImg=[[UIImageView alloc] initWithFrame:CGRectMake(139, 380, 44, 44)];
        _calImg.image=[UIImage imageNamed:@"fire.png"];
        _calImg.contentMode=UIViewContentModeScaleToFill;
        [self.view addSubview:_calImg];
        [self.view addSubview:_calCount];
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self refreshCoinsAndMonthDays];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SportDelegate
-(void)getMonthMoveDaysSuccess:(NSInteger)days{
    _monthMoveDays.text=[NSString stringWithFormat:@"%ld天",(long)days];
}
-(void) stepCountChange:(NSString *)stepCount {
    _stepCount.text=[NSString stringWithFormat:@"%@步",stepCount ];
    kCal=kCal+755;
    _calCount.text=[NSString stringWithFormat:@"%d千卡",kCal/1000];
}
-(void)sportTimeChange:(int)sportTime{
    if(sportCircleNumber<10000){
        sportCircleNumber=sportCircleNumber+1;
    }
    _wdSport.z=sportCircleNumber/10000;
    sportSec=sportTime;
    int hour=sportTime/60;
    int second=sportTime%60;
    [self setSportTime:[NSString stringWithFormat:@"%dm %ds",hour,second]];
}
#pragma mark - custom-method
-(void)setSportTime:(NSString*)time{
    _timeLabel.text=time;
}
-(void) refreshCoinsAndMonthDays{
    //一整个月的天数
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
    _coinsCount.text=user.coins;
}
/**
 *  当能量条清空时，调用此方法。
 */
-(void) sportCircleClear{
    self.fireBtn.progress = 0.4f;
    
    if(sportCircleNumber>5){
        //添加运动记录
        [_bl addMoveRecord:sportSec withSteps:stepNum];
        //        //userBL更新本地用户NSUserDefaults中的信息
        //        [_userBL refreshMyself];
        //userBL更新服务器中的金币信息
        SMS_MBProgressHUD *hud = [SMS_MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeDeterminate;
        UIView*view =[ [UIView alloc]init];
        view.backgroundColor= [UIColor clearColor];
        
        [hud setCustomView:view];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        hud.backgroundColor=[UIColor clearColor];
        hud.tintColor=[UIColor orangeColor];
        
        
        if(sportCircleNumber>3600){
            [_bl addCoins:@"36"];
            hud.labelText = [NSString stringWithFormat:@"恭喜您获得了%@个金币",@"36"];
        }else{
            double i=floor(sportCircleNumber/10);
            [_bl addCoins:[NSString stringWithFormat:@"%f",i]];
            hud.labelText = [NSString stringWithFormat:@"恭喜您获得了%0.0f个金币",i];
        }
        [hud hide:YES afterDelay:3];
        
        [self refreshCoinsAndMonthDays];
        sportCircleNumber=0;
        _wdSport.z=sportCircleNumber/3600;
        [self getCoinAction];
    }else{
        //        [_userBL addCoins:100];
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"能量条超过四分之一才能释放" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        
    }
}
#pragma mark - coins_bags
//统计金币数量的变量
static int coinCount = 0;
- (void)getCoinAction
{
    
    [_fireBtn setEnabled:false];
    isBag=false;
    //"立即打开"按钮从视图上移除
    
    [self.view addSubview:_bagView];
    
    //初始化金币生成的数量
    coinCount = 0;
    for (int i = 0; i<kCoinCountKey; i++) {
        
        //延迟调用函数
        [self performSelector:@selector(initCoinViewWithInt:) withObject:[NSNumber numberWithInt:i] afterDelay:i * 0.01];
    }
    
}

- (void)initCoinViewWithInt:(NSNumber *)i
{
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_coin_%d",[i intValue] % 2 + 1]]];
    
    //初始化金币的最终位置
    coin.center = CGPointMake(CGRectGetMidX(self.view.frame) + arc4random()%40 * (arc4random() %3 - 1) - 20, CGRectGetMidY(self.view.frame) - 55);
    coin.tag = [i intValue] + 1;
    //每生产一个金币,就把该金币对应的tag加入到数组中,用于判断当金币结束动画时和福袋交换层次关系,并从视图上移除
    [_coinTagsArr addObject:[NSNumber numberWithLong:coin.tag]];
    
    [self.view addSubview:coin];
    
    [self setAnimationWithLayer:coin];
}

- (void)setAnimationWithLayer:(UIView *)coin
{
    CGFloat duration = 1.6f;
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //绘制从底部到福袋口之间的抛物线
    CGFloat positionX   = coin.layer.position.x;    //终点x
    CGFloat positionY   = coin.layer.position.y;    //终点y
    CGMutablePathRef path = CGPathCreateMutable();
    int fromX       = arc4random() % 320;     //起始位置:x轴上随机生成一个位置
    int height      = [UIScreen mainScreen].bounds.size.height-49; //y轴以屏幕高度为准
    //     + coin.frame.size.height
    int fromY       = arc4random() % (int)positionY; //起始位置:生成位于福袋上方的随机一个y坐标
    
    CGFloat cpx = positionX + (fromX - positionX)/2;    //x控制点
    CGFloat cpy = fromY / 2 - positionY+44;                //y控制点,确保抛向的最大高度在屏幕内,并且在福袋上方(负数)
    
    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, height);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, positionX, positionY);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    CFRelease(path);
    path = nil;
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //图像由大到小的变化动画
    CGFloat from3DScale = 1 + arc4random() % 10 *0.1;
    CGFloat to3DScale = from3DScale * 0.5;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //动画组合
    group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[scaleAnimation, animation];
    [coin.layer addAnimation:group forKey:@"position and transform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        
        //动画完成后把金币和数组对应位置上的tag移除
        UIView *coinView = (UIView *)[self.view viewWithTag:[[_coinTagsArr firstObject] intValue]];
        
        
        
        if (!isBag) {
            
            [coinView removeFromSuperview];
            [_coinTagsArr removeObjectAtIndex:0];                    }else{
                
                [_bagView removeFromSuperview];
                isBag=false;
                
            }
        //全部金币完成动画后执行的动作
        if (++coinCount == kCoinCountKey) {
            isBag=true;
            [self bagShakeAnimation];
            [_fireBtn setEnabled:true];
        }
    }
}


//福袋晃动动画
- (void)bagShakeAnimation
{
    shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.delegate=self;
    shake.fromValue = [NSNumber numberWithFloat:- 0.2];
    shake.toValue   = [NSNumber numberWithFloat:+ 0.2];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 3;
    shake.removedOnCompletion = YES;
    [_bagView.layer addAnimation:shake forKey:@"bagShakeAnimation"];
    
}

- (IBAction)share:(id)sender {
    
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    NSArray* array;
    if ([WXApi isWXAppInstalled]) {
        array=[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil];
    }else{
        array=[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToQQ,nil];
    }
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
    NSString* name=user.nickName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:[NSString stringWithFormat:@"每天给自己一个奖励，快来加入里环王吧！%@",name]
                                     shareImage:image                                shareToSnsNames:array
                                       delegate:nil];
}
@end