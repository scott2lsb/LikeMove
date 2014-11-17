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
    static NSString *cellIdentifier = @"acceptFriend";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier ];
    }
    UILabel* nickname=(UILabel*)[cell viewWithTag:1];
    UILabel* phone=(UILabel*)[cell viewWithTag:2];
//    UIButton* reject=(UIButton*)[cell viewWithTag:3];
//    UIButton* accept=(UIButton*)[cell viewWithTag:4];
//    [accept addTarget:self action:@selector(acceptFriendRequest:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary* dict=[acceptFriends objectAtIndex:indexPath.row];
    DLog(@"%@",[dict objectForKey:@"nickname"]);
    nickname.text=[dict objectForKey:@"nickname"];
    phone.text=[dict objectForKey:@"phone"];
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
-(void)getAcceptFriendSuccess:(NSArray *)friends{
    [_spinner stopAnimating];
    if([friends isKindOfClass:[NSNull class]]){
        _acceptFriend.hidden=YES;
        UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"你还没有任何好友请求哦！";
        label.textColor=[UIColor grayColor];
        [self.view addSubview:label];
    }
    else{
        _acceptFriend.hidden=NO;
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
//    [acceptFriends removeObjectAtIndex:row];
//    [_acceptFriend deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
-(void)acceptFriendSuccess{
    
    [_bl getMyAccepts:@"1" perPage:@"20"];
}
@end
