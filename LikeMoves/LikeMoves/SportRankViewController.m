//
//  SportRankViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-9.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportRankViewController.h"
#import "RTSpinKitView.h"
@interface SportRankViewController (){
    NSArray* rankFriends;
    RTSpinKitView* spinner;
}

@end

@implementation SportRankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMContactBL alloc] init];
    _bl.delegate=self;
    rankFriends=[_bl getFriendSportRank:@"2014-09-08"];
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor orangeColor]];
    spinner.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    [self.view addSubview:spinner];
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
//    self.view.frame=CGRectMake(0,64,320,100);
//    self.tableView.frame=CGRectMake(0,64,320,100);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if([rankFriends isKindOfClass:[NSNull class]]){
        return 0;
    }
    return rankFriends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RankIdentifier = @"RankCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             RankIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: RankIdentifier ];
    }
    UILabel* nickname=(UILabel*)[cell viewWithTag:2];
//    UILabel* phone=(UILabel*)[cell viewWithTag:1];
    UILabel* duration=(UILabel*)[cell viewWithTag:1];
    UILabel* rank=(UILabel*)[cell viewWithTag:3];
    
    NSDictionary*friend=[rankFriends objectAtIndex:indexPath.row];
    DLog(@"----------------%@----------------",[friend objectForKey:@"nickname"]);
    rank.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    nickname.text=[friend objectForKey:@"nickname"];
    duration.text=[friend objectForKey:@"duration"];
//    nickname.text=rankFriends
    return cell;
}
#pragma mark - UITableView-Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 运动模块Delegate
-(void) getSportRankSuccess:(NSArray *)rank{
    [spinner stopAnimating];
    rankFriends=rank;
    DLog(@"%@",rankFriends);
    [self.tableView reloadData];
}
@end
