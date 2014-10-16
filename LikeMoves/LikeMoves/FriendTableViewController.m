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
    NSMutableArray* friendsTable;
    SectionsViewControllerFriends* _friendsController;
    
}
@end
static UIAlertView* _alert1=nil;
@implementation FriendTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMContactBL alloc] init];
    _bl.delegate=self;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    /**
     *  载入我的好友
     */
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_bl getFriends:@"1" perPage:@"10"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(friendsTable==nil){
        return 0;
    }
    return friendsTable.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FriendTableIdentifier = @"friendCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             FriendTableIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: FriendTableIdentifier ];
    }
    //昵称、当天运动时长、当月已运动天数、金币数量
    UILabel* nickname=(UILabel*)[cell viewWithTag:1];
//    UILabel* duration=(UILabel*)[cell viewWithTag:2];
//    UILabel* monthMove=(UILabel*)[cell viewWithTag:3];
    UILabel* coins=(UILabel*)[cell viewWithTag:4];
    NSDictionary* friend=[friendsTable objectAtIndex:indexPath.row];
    nickname.text=[friend objectForKey:@"nickname"];
    coins.text=[friend objectForKey:@"coins"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary* dict=[friendsTable objectAtIndex:indexPath.row];
        NSString* friend_id=[dict objectForKey:@"id"];
        [_bl delFriend:friend_id];
        
        [friendsTable removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        DLog(@"delete");
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
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
        friendsTable=nil;
        self.tableView.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有好友哦,快通过右上角添加吧！";
        label.font=[UIFont fontWithName: @"Helvetica"   size: 17.0 ];
        label.textColor=[UIColor grayColor];
        [self.view addSubview:label];

    }else{
        friendsTable= [friends mutableCopy];
        [self.tableView reloadData];

    }
    
    }
@end
