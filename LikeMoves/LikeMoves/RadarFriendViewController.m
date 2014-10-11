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


- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    NSInteger row=[self.radarTable indexPathForCell:((UITableViewCell*)[[sender superview]superview])].row;
    NSDictionary*dict=[_radarFriends objectAtIndex:row];
    NSString* user_id=[dict objectForKey:@"id"];
    [_bl addFriendByID:user_id];
    UIButton* btn=(UIButton*)sender;
    btn.titleLabel.text=@"已添加";

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
    static NSString *cellIdentifier = @"radarFriend";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier ];
    }
    //昵称、当天运动时长、当月已运动天数、金币数量
    UILabel* nickname=(UILabel*)[cell viewWithTag:1];
    UILabel* phone=(UILabel*)[cell viewWithTag:2];
    
    NSDictionary* friend=[_radarFriends objectAtIndex:indexPath.row];
    nickname.text=[friend objectForKey:@"nickname"];
    phone.text=[friend objectForKey:@"phone"];
    return cell;
}
#pragma mark - ContactBLDelegate
-(void)scanFriendSuccess:(NSArray *)scanFriend{
    _radarFriends=scanFriend;
    [_radarTable reloadData];
}
@end
