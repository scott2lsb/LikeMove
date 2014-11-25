//
//  RadarFriendViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-4.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "RadarFriendViewController.h"
@interface RadarFriendViewController ()

@end

@implementation RadarFriendViewController

RTSpinKitView* spinnerIndicator;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //指示框
    spinnerIndicator = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor orangeColor]];
    spinnerIndicator.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    [self.view addSubview:spinnerIndicator];
    [spinnerIndicator stopAnimating];
    //初始化
    _bl=[[LMContactBL alloc] init];
    _bl.delegate=self;
    _radarTable.delegate=self;
    _radarTable.dataSource=self;
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse color:[UIColor emerlandColor]];
    
    spinner.center = CGPointMake(160,189);
    
    [self.view addSubview:spinner];
    [self.view bringSubviewToFront:spinner];
    [spinner stopAnimating];
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.radarTable setTableFooterView:view];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_bl stopScanFriend];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 界面元素Action
- (IBAction)backTo:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)radarSearch:(id)sender {
    [spinner startAnimating];
    [_bl scanFriend:@"118.350838" withLatitude:@"35.06763"];
}

- (IBAction)addRadarFriend:(id)sender {
    UIButton* btn=(UIButton*)sender;
    NSInteger row=[self.radarTable indexPathForCell:(UITableViewCell*)[[btn superview]superview]].row;
    NSDictionary*dict=[_radarFriends objectAtIndex:row];
    DLog(@"row:%d",row);
//    NSString* user_id=[dict objectForKey:@"id"];
//    [_bl addFriendByID:user_id];
//    
    NSString* phone=[dict objectForKey:@"phone"];
    [_bl addFriendByPhone:phone];
    
    btn.titleLabel.text=@"已添加";
    [spinnerIndicator startAnimating];
    btn.enabled=NO;
    
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([_radarFriends isKindOfClass:[NSNull class]]){
        return 0;
    }
    return _radarFriends.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"radarFriend1";
    
    RadarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[RadarTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier ];
        cell.delegate=self;
    }
    //昵称、当天运动时长、当月已运动天数、金币数量

    UILabel* nickname=cell.nickname;
    UILabel* phone=cell.phone;
    NSDictionary* friend=[_radarFriends objectAtIndex:indexPath.row];
    nickname.text=[friend objectForKey:@"nickname"];
    phone.text=[friend objectForKey:@"phone"];
    
    cell.section=indexPath.section;
    cell.index=indexPath.row;
    return cell;
}
-(void)RadarCellBtnClick:(RadarTableViewCell *)cell{
    DLog(@"雷达界面添加好友-row:%ld,section:%ld",cell.index,cell.index);
    NSDictionary*dict=[_radarFriends objectAtIndex:cell.index];
    NSString* phone=[dict objectForKey:@"phone"];
    [_bl addFriendByPhone:phone];
    
    [spinnerIndicator startAnimating];
    cell.addFriendBtn.enabled=NO;
    
}
#pragma mark - ContactBLDelegate
-(void)scanFriendSuccess:(NSArray *)scanFriend{
    _radarFriends=scanFriend;
    [_radarTable reloadData];
}
-(void)addFriendByPhoneSuccess:(NSInteger)status{
    switch (status) {
        case 1:{
            //TODO: 成功加好友
            [spinnerIndicator stopAnimating];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"已请求添加好友!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            break;}
        case 6201:{
            //TODO: 已经添加此好友
            [spinnerIndicator stopAnimating];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"已请求添加好友，请耐心等待对方回应！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            break;}
        case 6202:{
            //TODO: 已经添加此好友
            [spinnerIndicator stopAnimating];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"此好友已添加！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            break;}

        default:
            break;
    }
    
}
@end
