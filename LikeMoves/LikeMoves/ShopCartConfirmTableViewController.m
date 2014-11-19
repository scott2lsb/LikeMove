//
//  ShopCartConfirmTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-10.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopCartConfirmTableViewController.h"

@interface ShopCartConfirmTableViewController ()

@end

@implementation ShopCartConfirmTableViewController

NSString* shipingMethod=@"2";
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _receiverID=@"0";
    _bl=[[LMShopBL alloc] init];
    _bl.delegate=self;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
    
    _coinNum.delegate=self;
    self.tableView.delegate=self;
    _total.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"totalPrice"] floatValue]];
    _maxDeduction.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"maxDeduction"] floatValue]];
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    _sumCoins.text=[NSString stringWithFormat:@"%@个",user.coins];
    _coinNum.clearsOnInsertion=YES;
    _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",[[_detail objectForKey:@"totalPrice"] floatValue]];
    float maxDeduction=[[_detail objectForKey:@"maxDeduction"] floatValue]*100;
    float coinNum=[user.coins floatValue];
    if (maxDeduction>coinNum) {
        _coinNum.text=[NSString stringWithFormat:@"%ld",lroundf(coinNum)];
        //计算显示金额
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",coinNum/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-coinNum/100 )];
    }else{
        _coinNum.text=[NSString stringWithFormat:@"%ld",lroundf(maxDeduction)];
        //计算显示金额
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",maxDeduction/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-maxDeduction/100 )];

    }
}
-(void)dismissKeyboard {
//    [_coinNum resignFirstResponder];
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    DLog(@"%d,%d,%d",indexPath.row,indexPath.section,[[_detail objectForKey:@"totalPrice"] intValue]);
    if(indexPath.row==1&indexPath.section==0&[[_detail objectForKey:@"totalPrice"] intValue]>39){
        shipingMethod=@"1";
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ReceiverPage"];
        
        [self.navigationController pushViewController:tabVC animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_coinNum resignFirstResponder];
}
#pragma mark - TextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{

    NSString* deduction=[_maxDeduction.text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    //NSUserDefaults刷新金币数量，使用NSUserDefaults中的数据
    User* user=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults                                                            standardUserDefaults] objectForKey:mUserInfo]];
    if([textField.text intValue]>[user.coins intValue] ){
        
        textField.text=@"0";
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"金币数量不足" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        //计算显示金额
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[textField.text floatValue]/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-[textField.text floatValue]/100 )];
    }else if([_coinNum.text intValue]>lroundf([deduction floatValue]*100)){
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"超过最大可抵扣额度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        textField.text=@"0";
        //计算显示金额
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[textField.text floatValue]/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-[textField.text floatValue]/100 )];
    }else{
        _deduction.text=[NSString stringWithFormat:@"￥%0.2f",[textField.text floatValue]/100];
        _realPrice.text=[NSString stringWithFormat:@"￥%0.2f",([[_detail objectForKey:@"totalPrice"] floatValue]-[textField.text floatValue]/100 )];
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

- (IBAction)confirmTo:(id)sender {
    NSString* ids=(NSString*)[_detail objectForKey:@"shopping_ids"];
    NSString* coinNum=_coinNum.text;

    [_bl addOrderWithShopIds:ids receiverID:_receiverID coins:coinNum comment:nil shipingMethod:shipingMethod phoneConfirm:nil userID:nil];
}
-(void)addCartToOrderSuccess:(NSDictionary *)data{
    //TODO: 跳转支付页面
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setValue:[data objectForKey:@"total_price"] forKey:@"total_price"];
    [dict setValue:[data objectForKey:@"id"]  forKey:@"order_id"];
    [dict setValue:[data objectForKey:@"need_coins"]  forKey:@"deduction_coins"];
    [dict setValue:[data objectForKey:@"need_cash"]  forKey:@"real_price" ];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PayToOrderTableViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"PayToOrderPage"];
    tabVC.dict=dict;
    [self.navigationController pushViewController:tabVC animated:YES];
}
@end
