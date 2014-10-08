//
//  LMLoginViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMLoginViewController.h"
#import "RegViewController.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "RTSpinKitView.h"
/// 登陆界面和注册界面
@interface LMLoginViewController (){
    RTSpinKitView* spinner;
}

/**
 *  登陆页面
 */
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *loginPwd;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet FUIButton *loginFUI;
@property (weak, nonatomic) IBOutlet FUIButton *resetPwdFUI;
@property (weak, nonatomic) IBOutlet FUIButton *registFUI;
/**
 *  Yes为regist
    No为reset
 */
@property (nonatomic) BOOL registOrReset;
- (IBAction)closeKeyboard:(id)sender;

/**
 *  登陆界面注册按钮监听事件
 *
 *  @param sender 注册按钮对象
 */
- (IBAction)toRegist:(id)sender;
/**
 *  登陆界面登陆按钮监听
 *
 *  @param sender 登陆按钮对象
 */
- (IBAction)login:(id)sender;
//登陆界面重置密码按钮
- (IBAction)loginPageResetPwd:(id)sender;

/**
 *  注册页面
 */
@property (weak, nonatomic) IBOutlet UILabel *registPhoneNum;

@property (weak, nonatomic) IBOutlet UITextField *registPwd;
- (IBAction)regist:(id)sender;

- (IBAction)back:(id)sender;
@end

@implementation LMLoginViewController

@synthesize phoneNum;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]) {
        [self performSelector:@selector(presentMainTabPage) withObject:nil afterDelay:2.0];
        //TODO: 添加等待指示框
        spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor whiteColor]];
        spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
        [self.view addSubview:spinner];
        self.view.layer.opaque=YES;
    }

        _bl=[LMUserActBL new];
    _bl.delegate=self;
    _registPhoneNum.text=phoneNum;
    //背景图片设置
    UIImageView* img=[[UIImageView alloc] initWithFrame:_loginView.bounds];
    img.image=[[UIImage imageNamed:@"launch"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [_loginView addSubview:img];
    [_loginView sendSubviewToBack:img];
    
    /**
     *  Login界面元素配置
     */
    
    //登陆按钮配置
    self.loginFUI.buttonColor = [UIColor turquoiseColor];
    self.loginFUI.shadowColor = [UIColor greenSeaColor];
    self.loginFUI.shadowHeight = 5.0f;
    self.loginFUI.cornerRadius = 6.0f;
    [self.loginFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.loginFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //忘记密码按钮配置
    self.resetPwdFUI.buttonColor = [UIColor turquoiseColor];
    self.resetPwdFUI.shadowColor = [UIColor greenSeaColor];
    self.resetPwdFUI.shadowHeight = 3.0f;
    self.resetPwdFUI.cornerRadius = 6.0f;
    [self.resetPwdFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.resetPwdFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //注册按钮配置
    self.registFUI.buttonColor = [UIColor turquoiseColor];
    self.registFUI.shadowColor = [UIColor greenSeaColor];
    self.registFUI.shadowHeight = 3.0f;
    self.registFUI.cornerRadius = 6.0f;
    [self.registFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.registFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    /**
     注册界面元素配置
     */
    
    /**
     *用户信息编辑界面的锻炼地点选择框
     */
    //初始化一下数据，分别为 所有源数据，和 已经选中的数据
	entries = [[NSArray alloc] initWithObjects:@"广场", @"小区周边", @"健身房", @"上下班路上", @"公园",@"其他",nil];
    
    entriesSelected = [[NSArray alloc] init];
	selectionStates = [[NSMutableDictionary alloc] init];
    
    // 配置是否选中状态
	for (NSString *key in entries){
        BOOL isSelected = NO;
        for (NSString *keyed in entriesSelected) {
            if ([key isEqualToString:keyed]) {
                isSelected = YES;
            }
        }
        [selectionStates setObject:[NSNumber numberWithBool:isSelected] forKey:key];
    }
    [_pickTrainPlace addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    
}
/**
 *  锻炼地点信息多选框
 */
-(void)getData
{
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
    multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,66, [UIScreen mainScreen].bounds.size.width, 260+44)];
    
    //  multiPickerView.backgroundColor = [UIColor redColor];
    multiPickerView.entriesArray = entries;
    multiPickerView.entriesSelectedArray = entriesSelected;
    multiPickerView.multiPickerDelegate = self;
    
    [self.view addSubview:multiPickerView];
    
    [multiPickerView pickerShow];
    
}

-(void)presentMainTabPage{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
        [spinner stopAnimating];}];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登陆界面按钮操作

- (IBAction)toRegist:(id)sender {
    RegViewController* reg=[[RegViewController alloc] init];
    reg.registOrReset=YES;
    [self presentViewController:reg animated:YES completion:^{
        
    }];
    
}
- (IBAction)loginPageResetPwd:(id)sender {
    RegViewController* reg=[[RegViewController alloc] init];
    reg.registOrReset=NO;
    [self presentViewController:reg animated:YES completion:^{
        
    }];

}
#pragma mark - 用户逻辑操作
- (IBAction)login:(id)sender {
    //指示框
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor emerlandColor]];
    spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    [self.view addSubview:spinner];
    //登陆逻辑
    [_bl login:_loginPhone.text withPassword:_loginPwd.text];
}

- (IBAction)regist:(id)sender {
    if (_shouTrainPlace.text.length==0||_registPwd.text.length==0) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"注册失败" message:@"密码或日常活动地点不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    } else if(_registPwd.text.length<8) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"注册失败" message:@"密码长度不能小于8位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
        //指示框
        spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor emerlandColor]];
        spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
        [self.view addSubview:spinner];
        //注册逻辑
        [_bl regist:_registPhoneNum.text withPassword:_registPwd.text withTrainPlace:_shouTrainPlace.text];
    }
    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 多选选择框Delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    DLog(@"selectedArray=%@",selectedEntriesArr);
    
    NSString *dataStr = [selectedEntriesArr componentsJoinedByString:@","];
    
    _shouTrainPlace.text = dataStr;
    // 再次初始化选中的数据
    entriesSelected = [NSArray arrayWithArray:selectedEntriesArr] ;
}



#pragma mark - LMUserBLDelegate 个人中心delegate方法
-(void)loginSuccess{
    //TODO: 跳转TAB页面
    [spinner stopAnimating];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
}

-(void)loginFail{
    
}
-(void)registSuccess{
    [spinner stopAnimating];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    

    
}

-(void)registFail{
    
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"注册成功"]) {//注册成功
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
        [self presentViewController:tabVC animated:YES completion:^(void){
        }];

    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)closeKeyboard:(id)sender {
    [_loginPhone resignFirstResponder];
    [_loginPwd resignFirstResponder];
}
- (IBAction)closeRegKeyboard:(id)sender {
    [_registPwd resignFirstResponder];
}
@end
