//
//  ReceiverViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-30.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ReceiverViewController.h"

@interface ReceiverViewController ()

@end

@implementation ReceiverViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    [_bl getReceiver];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView* view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
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

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: 处理删除收货地址操作
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSDictionary* dict=[friendsTable objectAtIndex:indexPath.row];
//        NSString* friend_id=[dict objectForKey:@"id"];
//        [_bl delFriend:friend_id];
//        
//        [friendsTable removeObjectAtIndex:indexPath.row];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        DLog(@"delete");
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 为表格行定义一个静态字符串作为标识符
	static NSString* cellIdentifier = @"ReceiverCell";
	// 从可重用表格行的队列中取出一个表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier];
    }
    
    UILabel* name=(UILabel*)[cell viewWithTag:1];
    UILabel* phone=(UILabel*)[cell viewWithTag:2];
    UILabel* adr=(UILabel*)[cell viewWithTag:3];

    NSDictionary* receiver=[_receivers objectAtIndex:indexPath.row];
    name.text=[receiver objectForKey:@"receiver"];
    phone.text=[NSString stringWithFormat:@"%@",[receiver objectForKey:@"phone"]];
    adr.text=[NSString stringWithFormat:@"%@",[receiver objectForKey:@"address"]];
	return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _receivers.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - ShopBLDelegate
-(void)getReceiversSuccess:(NSArray *)array{
    _receivers=array;
    [_tableView reloadData];
}
@end
