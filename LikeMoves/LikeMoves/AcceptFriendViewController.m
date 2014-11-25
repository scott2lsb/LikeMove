//
//  AcceptFriendViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-10.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "AcceptFriendViewController.h"

@interface AcceptFriendViewController ()

@end

@implementation AcceptFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMContactBL alloc]init];
    _bl.delegate=self;
    _acceptFriend.delegate=self;
    _acceptFriend.dataSource=self;
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.acceptFriend setTableFooterView:view];
    //    [_bl getMyAccepts:@"1" perPage:@"20"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor orangeColor]];
    _spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    [self.view addSubview:_spinner];
    
    [_bl getMyAccepts:@"1" perPage:@"20"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableViewCell-Delegate
-(void)AcceptFriendCellBtnClick:(AcceptFriendTableViewCell *)cell{
    [_spinner startAnimating];
    
    NSInteger row=cell.index;
    NSDictionary*dict=[acceptFriends objectAtIndex:row];
    NSString* user_id=[dict objectForKey:@"id"];
    [_bl acceptFriend:user_id];
}
-(void)RejectFriendCellBtnClick:(AcceptFriendTableViewCell *)cell{
    [_spinner startAnimating];
    
    NSInteger row=cell.index;
    NSDictionary*dict=[acceptFriends objectAtIndex:row];
    NSString* user_id=[dict objectForKey:@"id"];
    [_bl rejectFriend:user_id];

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
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"acceptFriend1";
    
    AcceptFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                       cellIdentifier ];
    if (cell == nil) {
        cell = [[AcceptFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                reuseIdentifier: cellIdentifier ];
        cell.delegate=self;
    }
    
    UILabel* nickname=    cell.nickname;
    UILabel* phone=cell.phone;
    NSDictionary* dict=[acceptFriends objectAtIndex:indexPath.row];
    DLog(@"%@",[dict objectForKey:@"nickname"]);
    nickname.text=[dict objectForKey:@"nickname"];
    phone.text=[dict objectForKey:@"phone"];
    cell.index=indexPath.row;
    cell.section=indexPath.section;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([acceptFriends isKindOfClass:[NSNull class]]){
        return 0;
    }
    return acceptFriends.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
};

#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - ContactBLDelegate
UILabel* label;
-(void)getAcceptFriendSuccess:(NSArray *)friends{
    [_spinner stopAnimating];
    
    if([friends isKindOfClass:[NSNull class]]){
        _acceptFriend.hidden=YES;
        label=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有任何好友请求哦！";
        label.textColor=[UIColor grayColor];
        [self.view addSubview:label];
    }
    else{
        _acceptFriend.hidden=NO;
        label.hidden=YES;
        acceptFriends=[friends mutableCopy];
        [_acceptFriend reloadData];
    }
}
#pragma mark - 界面元素
- (IBAction)acceptFriend:(id)sender {
    [_spinner startAnimating];
    NSIndexPath* index=[self.acceptFriend indexPathForCell:((UITableViewCell*)[[sender superview]superview])];
    NSInteger row=index.row;
    NSDictionary*dict=[acceptFriends objectAtIndex:row];
    NSString* user_id=[dict objectForKey:@"id"];
    [_bl acceptFriend:user_id];
    
}
-(void)acceptFriendSuccess{
    [_spinner stopAnimating];
    [_bl getMyAccepts:@"1" perPage:@"20"];
}
-(void)rejectFriendSuccess{
    [_spinner stopAnimating];
    [_bl getMyAccepts:@"1" perPage:@"20"];
}
@end
