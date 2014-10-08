//
//  VerifyViewController.m
//  SMS_SDKDemo
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "VerifyViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "SMS_MBProgressHUD+Add.h"
#import <SMS_SDK/SMS_UserInfo.h>
#import <SMS_SDK/SMS_SRUtils.h>
#import <SMS_SDK/SMS_AddressBook.h>
#import <AddressBook/AddressBook.h>



@interface VerifyViewController ()
{
    //NSString* _str;
    SMS_SDK* _sdk;
    NSString* _phone;
    NSString* _areaCode;
    
    int _state;
    NSMutableData* _data;
    NSString* _localVerifyCode;
    NSString* _appKey;
    NSString* _appSecret;
    
    NSString* _duid;
    NSString* _token;
    
    NSString* _localPhoneNumber;
    NSString* _localZoneNumber;
    
    NSMutableArray* _addressBookTemp;
    
    NSString* _contactkey;
    
    SMS_UserInfo* _localUser;
    
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;
    
    UIAlertView* _alert1;
    UIAlertView* _alert2;
    
    UIAlertView* _alert3;

}

@end

static int count = 0;

//最近新好友信息
static NSMutableArray* _userData2;

//最近新好友 条数
//static int latelyFriendsCount=0;

@implementation VerifyViewController

-(void)clickLeftButton
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码短信可能略有延迟,确定返回并重新开始" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"等待", nil];
    _alert2=alert;
    [alert show];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setPhone:(NSString*)phone AndAreaCode:(NSString*)areaCode
{
    _phone=phone;
    _areaCode=areaCode;
}

-(void)submit
{
    //验证号码
    //验证成功后 获取通讯录 上传通讯录
    //
    [self.view endEditing:YES];
    
    if(self.verifyCodeField.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码格式错误,请重新填写" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"去服务端进行验证中...");
        
        //[[SMS_SDK sharedInstance] commitVerifyCode:self.verifyCodeField.text];
        [SMS_SDK commitVerifyCode:self.verifyCodeField.text result:^(enum SMS_ResponseState state) {
            if (1==state) {
                NSLog(@"block 验证成功");
                NSString* str=[NSString stringWithFormat:@"验证码正确"];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"验证成功" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                _alert3=alert;
            }
            else if(0==state)
            {
                NSLog(@"block 验证失败");
                NSString* str=[NSString stringWithFormat:@"验证码无效 请重新获取验证码"];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"验证失败" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}


-(void)CannotGetSMS
{
    NSString* str=[NSString stringWithFormat:@"我们将重新发送验证码短信到这个号码:%@",_phone];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"确认手机号码" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    _alert1=alert;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_alert1) {
        if (1==buttonIndex)
        {
            NSLog(@"重发验证码");
            //[[SMS_SDK sharedInstance] getVerifyCodeByPhoneNumber:_phone AndZone:_areaCode];
            [SMS_SDK getVerifyCodeByPhoneNumber:_phone AndZone:_areaCode result:^(enum SMS_GetVerifyCodeResponseState state) {
                if (1==state) {
                    NSLog(@"block 获取验证码成功");
                }
                else if(0==state)
                {
                    NSLog(@"block 获取验证码失败");
                    NSString* str=[NSString stringWithFormat:@"验证码发送失败 请稍后重试"];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"发送失败" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if (SMS_ResponseStateMaxVerifyCode==state)
                {
                    NSString* str=[NSString stringWithFormat:@"请求验证码超上限 请稍后重试"];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"超过上限" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
                {
                    NSString* str=[NSString stringWithFormat:@"客户端请求发送短信验证过于频繁"];
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }

            }];

        }
        
    }
    
    if (alertView==_alert2) {
        if (0==buttonIndex)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [_timer2 invalidate];
                [_timer1 invalidate];
            }];
        }
        if (1==buttonIndex) {
            ;
        }
    }
    
    if (alertView==_alert3) {
        if (self.registOrReset) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *registVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RegistPage"];
            [registVC setValue:_phone forKey:@"phoneNum"];
            [self presentViewController:registVC animated:YES completion:^(void){
                //解决等待时间乱跳的问题
                [_timer2 invalidate];
                [_timer1 invalidate];
                
            }];

        } else {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *resetVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResetPwd"];
            [resetVC setValue:_phone forKey:@"phoneNum"];
            [self presentViewController:resetVC animated:YES completion:^(void){
                //解决等待时间乱跳的问题
                [_timer2 invalidate];
                [_timer1 invalidate];
                
            }];

        }
        
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat statusBarHeight=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight=20;
    }
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, 320, 44)];
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(clickLeftButton)];
    leftButton.tintColor=[UIColor orangeColor];
    //设置导航栏内容
    [navigationItem setTitle:@"验证码"];
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
    UILabel* label=[[UILabel alloc] init];
    label.frame=CGRectMake(20, 53+statusBarHeight, 280, 21);
    label.text=[NSString stringWithFormat:@"我们已发送验证码到这个号码"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:label];
    
    _telLabel=[[UILabel alloc] init];
    _telLabel.frame=CGRectMake(85, 82+statusBarHeight, 158, 21);
    _telLabel.textAlignment = NSTextAlignmentCenter;
    _telLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:_telLabel];
    
    _verifyCodeField=[[UITextField alloc] init];
    _verifyCodeField.frame=CGRectMake(85, 111+statusBarHeight, 158, 46);
    _verifyCodeField.borderStyle=UITextBorderStyleBezel;
    _verifyCodeField.textAlignment=NSTextAlignmentCenter;
    _verifyCodeField.placeholder=@"验证码";
    _verifyCodeField.font=[UIFont fontWithName:@"Helvetica" size:27];
    _verifyCodeField.keyboardType=UIKeyboardTypePhonePad;
    _verifyCodeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:_verifyCodeField];
    
    _timeLabel=[[UILabel alloc] init];
    _timeLabel.frame=CGRectMake(64, 169+statusBarHeight, 200, 21);
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _timeLabel.text=@"接受短信大约需要60秒";
    [self.view addSubview:_timeLabel];
    
    _repeatSMSBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _repeatSMSBtn.frame=CGRectMake(96, 165+statusBarHeight, 137, 30);
    [_repeatSMSBtn setTitle:@"收不到验证码？" forState:UIControlStateNormal];
    [_repeatSMSBtn addTarget:self action:@selector(CannotGetSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_repeatSMSBtn];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button4.png"];
    [_submitBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    _submitBtn.frame=CGRectMake(9, 209+statusBarHeight, 303, 42);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];


    self.telLabel.text=_phone;
    
    self.repeatSMSBtn.hidden=YES;
    
    [_timer2 invalidate];
    [_timer1 invalidate];
    
    count = 0;
    
    NSTimer* timer=[NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(showRepeatButton)
                                         userInfo:nil
                                          repeats:YES];
    
    NSTimer* timer2=[NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(updateTime)
                                                  userInfo:nil
                                                   repeats:YES];
    _timer1=timer;
    _timer2=timer2;
    
    [SMS_MBProgressHUD showMessag:@"正在发送中..." toView:self.view];
    
}

-(void)updateTime
{
    count++;
    if (count>=60) {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    self.timeLabel.text=[NSString stringWithFormat:@"接受短信大约需要%i秒",60-count];
}

-(void)showRepeatButton{
    NSLog(@"显示重复短信按钮");
    self.timeLabel.hidden=YES;
    self.repeatSMSBtn.hidden=NO;
    
    [_timer1 invalidate];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
