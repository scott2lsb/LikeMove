//
//  InvitationViewControllerEx.m
//  SMS_SDKDemo
//
//  Created by 严军 on 14-7-15.
//  Copyright (c) 2014年 严军. All rights reserved.
//

#import "InvitationViewControllerEx.h"
#import <SMS_SDK/SMS_SDK.h>

@interface InvitationViewControllerEx ()
{
    NSString* _name;
    SMS_SDK* _sdk;
    NSString* _phone;
    NSString* _phone2;
}

@end

@implementation InvitationViewControllerEx

-(void)clickLeftButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

-(void)setData:(NSString *)name
{
    _name=name;
}


-(void)setPhone:(NSString *)phone AndPhone2:(NSString*)phone2
{
    _phone=phone;
    _phone2=phone2;
}

-(void)sendInvite
{
    //发送短信
    NSLog(@"发送短信");
    if ([_phone2 length]>0) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"选择要发送邀请的号码" delegate:self cancelButtonTitle:_phone otherButtonTitles:_phone2, nil];
        [alert show];
    }
    else
    {
        //[_sdk sendSMS:_phone?_phone:@"18927512076"];
        [SMS_SDK sendSMS:_phone?_phone:@"18927512076" AndMessage:@"快加入SMS_SDK吧,网址为http://www.sharesdk.cn"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1==buttonIndex)
    {
        //[_sdk sendSMS:_phone2?_phone2:@"18927512076"];
        [SMS_SDK sendSMS:_phone?_phone:@"18927512076" AndMessage:@"快加入SMS_SDK吧,网址为http://www.sharesdk.cn"];
    }
    if (0==buttonIndex)
    {
        //[_sdk sendSMS:_phone?_phone:@"18927512076"];
        [SMS_SDK sendSMS:_phone?_phone:@"18927512076" AndMessage:@"快加入SMS_SDK吧,网址为http://www.sharesdk.cn"];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保证性能问题
    static NSString *identifier = @"UITableViewCell";
    
    // 1.拿一个标识去缓存池里面找可循环利用的Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        // 2.如果没有可循环利用的Cell，就必须创建一个Cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
        
    }
    cell.textLabel.text=_name;
    
    cell.imageView.image=[UIImage imageNamed:@"2.png"];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"手机号:%@ %@",_phone?_phone:@"18927512076",_phone2?_phone2:@""];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
    UITableView* tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44+statusBarHeight, 320, 80) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"发送邀请" forState:UIControlStateNormal];
    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button4.png"];
    [btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.frame=CGRectMake(11, 198+statusBarHeight, 299, 42);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(sendInvite) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UILabel* label=[[UILabel alloc] init];
    label.frame=CGRectMake(0, 146+statusBarHeight, 320, 27);
    label.text=[NSString stringWithFormat:@"%@还未加入",_name];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:13];
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
