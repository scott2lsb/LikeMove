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
//    [_bl getReceiver];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView* view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    int index=[[self.navigationController viewControllers]indexOfObject:self];
    
    if([[self.navigationController.viewControllers objectAtIndex:index-1] isKindOfClass:[ShopCartConfirmTableViewController class]]){
        DLog(@"test");
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_bl getReceiver];
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
    int index=[[self.navigationController viewControllers]indexOfObject:self];
    
    if([[self.navigationController.viewControllers objectAtIndex:index-1] isKindOfClass:[ShopCartConfirmTableViewController class]]){
        NSDictionary* receiver=[_receivers objectAtIndex:indexPath.row];
        ShopCartConfirmTableViewController* shop=[self.navigationController.viewControllers objectAtIndex:index-1] ;
        shop.receiverAdr.text=[receiver objectForKey:@"address"];
        shop.receiverName.text=[receiver objectForKey:@"receiver"] ;
        shop.receiverPhone.text=[receiver objectForKey:@"phone"];
        shop.receiverID=[receiver objectForKey:@"id"];
    }//    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: 处理删除收货地址操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary* dict=[_receivers objectAtIndex:indexPath.row];
        NSString* friend_id=[dict objectForKey:@"id"];
        [_bl delReceiver:friend_id];
        
        [_receivers removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        DLog(@"delete");
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
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
    if (_receivers==nil) {
        return 0;
    }
    return _receivers.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - ShopBLDelegate
UILabel* label;
-(void)getReceiversSuccess:(NSArray *)array{
    if([array isKindOfClass:[NSNull class]]){
        _receivers=nil;
        _tableView.hidden=YES;
 label=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"您还没有添加收货地址哦！";
        label.textColor=[UIColor grayColor];
        [self.view addSubview:label];
    }
    else{
        _tableView.hidden=NO;
        label.hidden=YES;
          _receivers=[array mutableCopy];
        [_tableView reloadData];
    }
}
@end
