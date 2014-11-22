//
//  FriendTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-4.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "FriendTableViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "SMS_HYZBadgeView.h"
#import "RegViewController.h"
#import "SectionsViewControllerFriends.h"
#import "SMS_MBProgressHUD+Add.h"
#import <AddressBook/AddressBook.h>
@interface FriendTableViewController ()
{
    
    SectionsViewControllerFriends* _friendsController;
    
}
@end
static UIAlertView* _alert1=nil;
@implementation FriendTableViewController
RTSpinKitView* spinner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化
    _bl=[[LMContactBL alloc] init];
    _bl.delegate=self;
    _shopBL=[[LMShopBL alloc] init];
    _shopBL.delegate=self;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tag=0;
    /**
     *  载入我的好友
     */
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UIImageView* img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friend_table_header"]];
    [self.tableView setTableHeaderView:img];
    [self.tableView setTableFooterView:view];
    /**
     *  众筹好友列表
     */
    _crowdfundFriendTableView=[[UITableView alloc]initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height-64-44-49)];
    _crowdfundFriendTableView.tag=1;
    [_crowdfundFriendTableView setTableFooterView:view];
    _crowdfundFriendTableView.dataSource=self;
    _crowdfundFriendTableView.delegate=self;
    /**
     *  scroll
     *
     *  @return nil
     */
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat yDelta;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    
    // Minimum code required to use the segmented control with the default styling.
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"好友排行", @"众筹列表"]];
    _segmentedControl.frame = CGRectMake(0, 0 +44+ yDelta, 320, 44);
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorColor=[UIColor orangeColor];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(320 * index, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,108, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(640, [[UIScreen mainScreen]bounds].size.height-20-44-44-49);
    //    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled=NO;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:NO];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:_tableView];
    [self.scrollView addSubview:_crowdfundFriendTableView];
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor orangeColor]];
    spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    [self.navigationController.view addSubview:spinner];
    [spinner startAnimating];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [_bl getFriendSportRank:currentDateStr];
    //    [_bl getFriends:@"1" perPage:@"20"];
    [_bl getCrowdfundFriends];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	DLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView.tag==0){
        if(_rankFriends==nil){
            return 0;
        }
        return _rankFriends.count;
    }else{
        if(_crowdfundFriends==nil){
            return 0;
        }
        
        return _crowdfundFriends.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(tableView.tag==0){
        static NSString *FriendTableIdentifier = @"friendCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:
                FriendTableIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier: FriendTableIdentifier ];
        }
        //昵称、当天运动时长、当月已运动天数、金币数量
        UILabel* nickname=(UILabel*)[cell viewWithTag:1];
        UILabel* duration=(UILabel*)[cell viewWithTag:2];
        UILabel* monthMove=(UILabel*)[cell viewWithTag:3];
        UILabel* coins=(UILabel*)[cell viewWithTag:4];
        UILabel* rank=(UILabel*)[cell viewWithTag:5];
        NSDictionary* friend=[_rankFriends objectAtIndex:indexPath.row];
        nickname.text=[friend objectForKey:@"nickname"];
        duration.text=[self timeFormat:[friend objectForKey:@"duration"]];
        monthMove.text=[NSString stringWithFormat:@"%@",[friend objectForKey:@"month_move_days"]];
        coins.text=[friend objectForKey:@"coins"];
        rank.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    }else{
        static NSString *crowdfundFriendTableIdentifier = @"crowdfundFriendCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:
                crowdfundFriendTableIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier: crowdfundFriendTableIdentifier ];
        }
        
        //昵称、当天运动时长、当月已运动天数、金币数量
        UILabel* nickname=(UILabel*)[cell viewWithTag:1];
        UILabel* duration=(UILabel*)[cell viewWithTag:2];
        //        UILabel* helpWords=(UILabel*)[cell viewWithTag:3];
        
        NSDictionary* friend=[_crowdfundFriends objectAtIndex:indexPath.row];
        DLog(@"%@",friend);
        nickname.text=[friend objectForKey:@"nickname"];
        duration.text=[self timeFormat:[friend objectForKey:@"day_move_duration"]];
        cell.detailTextLabel.text=@"江湖救急，快点我捐金币啦！";
        cell.textLabel.text=[NSString stringWithFormat:@"%@ :",[friend objectForKey:@"nickname"] ];
        ;
        //        helpWords.text=[NSString stringWithFormat:@"%@",[friend objectForKey:@"month_move_days"]];
        
        //        rank.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate
NSString* friendID;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag==1){
        NSDictionary* dict=[_crowdfundFriends objectAtIndex:indexPath.row];
        NSString* name=[dict objectForKey:@"nickname"];
        friendID=[dict objectForKey:@"id"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"赠送金币给%@",name]
                              message:@"请输入您要赠送的金币数量"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定" , nil];
        // 设置该警告框显示输入数字，只有一个输入框
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        // 设置第1个文本框关联的键盘只是数字键盘
        [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
        alert.tag=1;
        // 显示UIAlertView
        [alert show];
    }else{
        NSDictionary* dict=[_rankFriends objectAtIndex:indexPath.row];
        NSString* name=[dict objectForKey:@"nickname"];
        friendID=[dict objectForKey:@"id"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"确定要删除好友“%@”吗？",name]
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定" , nil];
        alert.tag=2;
        alert.alertViewStyle=UIAlertViewStyleDefault;
        [alert show];
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1&alertView.tag==1){
        // 获取UIAlertView中第1个输入框
		UITextField* nameField = [alertView textFieldAtIndex:0];
        User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:mUserInfo]];
        
        if([user.coins intValue]>[nameField.text intValue]){
            [_shopBL giveCoinsToFriend:friendID withCoins:nameField.text];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"金币不足！"
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil , nil];
            // 显示UIAlertView
            [alert show];
        }
    }else if(buttonIndex==1&alertView.tag==2){
        [_bl delFriend:friendID];
        [spinner startAnimating];
    }
}
#pragma mark - 界面元素监听方法
- (IBAction)searchFriend:(id)sender {
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    [menuView addMenuItemWithTitle:@"雷达" andIcon:[UIImage imageNamed:@"radar_friend.png"] andSelectedBlock:^{
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *radarVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RadarFriend"];
        [self.navigationController pushViewController:radarVC animated:YES];
    }];
    [menuView addMenuItemWithTitle:@"通讯录" andIcon:[UIImage imageNamed:@"contact_friend2.png"] andSelectedBlock:^{
        DLog(@"show my friends");
        SectionsViewControllerFriends* friends=[[SectionsViewControllerFriends alloc] init];
        _friendsController=friends;
        
        [_friendsController setMyBlock:_friendsBlock];
        
        [SMS_MBProgressHUD showMessag:@"正在加载中..." toView:self.view];
        
        [SMS_SDK getAppContactFriends:1 result:^(enum SMS_ResponseState state, NSArray *array) {
            if (1==state)
            {
                DLog(@"block 获取好友列表成功");
                
                [_friendsController setMyData:[array mutableCopy]];
                [self.navigationController pushViewController:_friendsController animated:YES ];
            }
            else if(0==state)
            {
                DLog(@"block 获取好友列表失败");
            }
            
        }];
        
        //判断用户通讯录是否授权
        if (_alert1) {
            [_alert1 show];
        }
        
        if(ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized&&_alert1==nil)
        {
            NSString* str=[NSString stringWithFormat:@"您未授权访问联系人，请在【设置>隐私>通讯录】中授权访问，就可以看到通讯录好友了哦"];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            _alert1=alert;
            [alert show];
        }
        
        
        
    }];
    [menuView addMenuItemWithTitle:@"手机号" andIcon:[UIImage imageNamed:@"phone_friend.png"] andSelectedBlock:^{
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *phoneVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"PhoneFriend"];
        [self.navigationController pushViewController:phoneVC animated:YES];
    }];
    [menuView show];
}
#pragma mark - ContactBLDelegate 代理
-(void)getFriendsSuccess:(NSArray *)friends{
    if ([friends isKindOfClass:[NSNull class]]) {
        _crowdfundFriends=nil;
        self.tableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有好友哦,快通过右上角添加吧！";
        label.font=[UIFont fontWithName: @"Helvetica"   size: 17.0 ];
        label.textColor=[UIColor grayColor];
        [self.view addSubview:label];
        
    }else{
        _rankFriends= [friends mutableCopy];
        [self.tableView reloadData];
    }
}
-(void)giveCoinsToFriendSuccess{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"赠送成功！"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil , nil];
    // 显示UIAlertView
    [alert show];
}
#pragma mark - 运动模块Delegate
-(void) getSportRankSuccess:(NSArray *)rank{
    [spinner stopAnimating];
    if([rank isKindOfClass:[NSNull class]]){
        _rankFriends=nil;
    }else{
        _rankFriends=[rank mutableCopy];
        int changeRank=0;
        int userRank=0;
        DXAlertView * alert;
        //TODO：排名进行处理
        User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
        NSString* rankDefault=[[NSUserDefaults standardUserDefaults]  objectForKey:mUserRank];
        
        if (rankDefault==nil) {
            for (int i=0; i<_rankFriends.count; i++) {
                NSString* userID=[[_rankFriends objectAtIndex:i ] objectForKey:@"id"];
                if ([user.userId isEqualToString:userID]) {
                    userRank=i+1;

                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",userRank] forKey:mUserRank];
                }
            }
        }else{
            for (int i=0; i<_rankFriends.count; i++) {
                NSString* userID=[[_rankFriends objectAtIndex:i ] objectForKey:@"id"];
                if ([user.userId isEqualToString:userID]) {
                    userRank=i+1;
                    changeRank=i+1-[rankDefault intValue];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",userRank] forKey:mUserRank];
                }
            }
            
            if (changeRank<0) {
                alert = [[DXAlertView alloc] initWithTitle:nil contentText:[NSString stringWithFormat:@"你的排名上升了%d位！",-changeRank] leftButtonTitle:nil rightButtonTitle:@"知道了"];
            }else if(changeRank>0){
                alert = [[DXAlertView alloc] initWithTitle:nil contentText:[NSString stringWithFormat:@"你的排名下降了%d位！",changeRank] leftButtonTitle:nil rightButtonTitle:@"知道了"];
            }
            
            [alert show];
        }
       
        alert.rightBlock = ^() {
            DLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
            DLog(@"Do something interesting after dismiss block");
        };
    }
    //    DLog(@"%@",_rankFriends);
    [self.tableView reloadData];
}
-(void) getCrowdfundFriendsSuccess:(NSArray *)friends{
    UILabel* label;
    if([friends isKindOfClass:[NSNull class]]){
        _crowdfundFriends=nil;
        _crowdfundFriendTableView.hidden=YES;
        label=[[UILabel alloc] initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height-108-49)];
        label.font=[UIFont systemFontOfSize:18.0];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"还没有人众筹哦！";
        label.backgroundColor=[UIColor whiteColor];
        label.textColor=[UIColor grayColor];
        label.enabled=NO;
        [self.scrollView addSubview:label];
    }else{
        label.hidden=YES;
        _crowdfundFriendTableView.hidden=NO;
        _crowdfundFriends=[friends mutableCopy];
    }
    [self.crowdfundFriendTableView reloadData];
}
-(void)delFriendByIDSuccess:(NSInteger)status{
    [spinner stopAnimating];
    switch (status) {
        case 1:
        {
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //用[NSDate date]可以获取系统当前时间
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            [_bl getFriendSportRank:currentDateStr];
            
            break;
        }
        default:
            break;
    }
}
#pragma mark - UIScrollDelegate

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat pageWidth = scrollView.frame.size.width;
//    NSInteger page = scrollView.contentOffset.x / pageWidth;
//
//    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
//}
-(NSString*)timeFormat:(NSString*)time{
    int sportTime=[time intValue];
    int hour=sportTime/60;
    int second=sportTime%60;
    return [NSString stringWithFormat:@"%dm %ds",hour,second];
}
@end
