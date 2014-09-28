//
//  SportViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-22.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportViewController.h"
#import "UIColor+FlatUI.h"
#define kCoinCountKey   100
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
    [self setFireBtnTitle:@"0m0s"];
    
    [_wdSport addSubview:_fireBtn];
    
    
    /**
     *  coins bags 福袋动画
     */
    _coinTagsArr = [NSMutableArray new];
    
    //主福袋层
    _bagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_hongbao_bags"]];
    _bagView.center = CGPointMake(CGRectGetMidX(self.view.frame) + 10, CGRectGetMidY(self.view.frame) - 45);
    
    [_fireBtn addTarget:self action:@selector(getCoinAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
#pragma mark - coins_bags
//统计金币数量的变量
static int coinCount = 0;
- (void)getCoinAction:(UIButton *)btn
{   [_fireBtn setEnabled:false];
    isBag=false;
    //"立即打开"按钮从视图上移除
//    [btn removeFromSuperview];
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
    coin.center = CGPointMake(CGRectGetMidX(self.view.frame) + arc4random()%40 * (arc4random() %3 - 1) - 20, CGRectGetMidY(self.view.frame) - 40);
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
    shake.repeatCount = 4;
    shake.removedOnCompletion = YES;
    [_bagView.layer addAnimation:shake forKey:@"bagShakeAnimation"];
    
}

@end