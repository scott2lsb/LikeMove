//
//  PayToOrderTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "PayToOrderTableViewController.h"

@interface PayToOrderTableViewController ()

@end

@implementation PayToOrderTableViewController
NSString* orderID;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    UIView*view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _userBalance.text=[NSString stringWithFormat:@"￥%0.2f",[user.balance floatValue]];
    _totalPrice.text=[NSString stringWithFormat:@"￥%0.2f",[[_dict objectForKey:@"total_price"] floatValue]];
    _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[[_dict objectForKey:@"deduction_coins"] floatValue]/100];
    _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",[[_dict objectForKey:@"real_price"] floatValue]];
    orderID=[_dict objectForKey:@"order_id"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - TableView Delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.section==1&indexPath.row==0) {
        //TODO:余额支付
        DLog(@"余额支付");
        [_bl payOrderWithOrderID:orderID];
    }else if (indexPath.section==1&indexPath.row==1){
        //TODO:支付宝支付
        DLog(@"支付宝支付");
    }else{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
    }
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

- (IBAction)cancelPayTo:(id)sender {
    int index=[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}
#pragma mark - SHOPBL Delegate
-(void)payWithBalanceSuccess{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"付款成功" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    alert.tag=0;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==0&buttonIndex==0) {
        
        int index=[[self.navigationController viewControllers]indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
        
    }

}
@end
